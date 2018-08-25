//
//  CoreDataManager.swift
//  MBLibrary
//
//  Created by Marco Boschi on 23/08/2018.
//  Part of code are from Alexander Grebenyuk tutorials at http://kean.github.io/post/core-data-progressive-migrations and https://gist.github.com/kean/28439b29532993b620497621a4545789
//  Copyright © 2018 Marco Boschi. All rights reserved.
//

import Foundation
import CoreData

public enum MBCoreDataError: Error {
	case incompatibleModels
	case notAStore
}

public class CoreDataManager {

	private let storeType = NSSQLiteStoreType
	private let storeURL: URL
	private let moms: [NSManagedObjectModel]
	private let mappingBundles: [Bundle]
	
	public init(store url: URL, withModelHistory moms: [NSManagedObjectModel], mappingBundles: [Bundle]? = nil) {
		precondition(!moms.isEmpty, "You cannot use CoreData without a Managed Object Model")
		
		self.storeURL = url
		self.moms = moms
		self.mappingBundles = mappingBundles ?? Bundle.allBundles + Bundle.allFrameworks
	}
	
	/// Migrate the store to the latest model if necessary and loads it in a new persistent store coordinator.
	/// - returns: The new persistent store coordinator for the store.
	public func getStoreCoordinator() throws -> NSPersistentStoreCoordinator {
		do {
			try migrateStore()
		} catch MBCoreDataError.notAStore {
			if FileManager.default.fileExists(atPath: storeURL.absoluteString) {
				try FileManager.default.removeItem(at: storeURL)
			}
		} catch MBCoreDataError.incompatibleModels {
			try FileManager.default.removeItem(at: storeURL)
		} catch let e {
			throw e
		}
		
		let coordinator = NSPersistentStoreCoordinator(managedObjectModel: moms.last!)
		try coordinator.addPersistentStore(ofType: storeType, configurationName: nil, at: storeURL)
		
		return coordinator
	}
	
	private func migrateStore() throws {
		let idx = try indexOfCompatibleMom(at: storeURL, moms: moms)
		let remaining = moms.suffix(from: (idx + 1))
		guard remaining.count > 0 else {
			// The store already uses the latest model
			return
		}
		
		_ = try remaining.reduce(moms[idx]) { sMom, dMom in
			try migrateStore(from: sMom, to: dMom)
			
			return dMom
		}
	}
	
	private func indexOfCompatibleMom(at storeURL: URL, moms: [NSManagedObjectModel]) throws -> Int {
		do {
			let meta = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: storeType, at: storeURL)
			
			guard let idx = moms.index(where: { $0.isConfiguration(withName: nil, compatibleWithStoreMetadata: meta) }) else {
				throw MBCoreDataError.incompatibleModels
			}
			
			return idx
		} catch MBCoreDataError.incompatibleModels {
			throw MBCoreDataError.incompatibleModels
		} catch _ {
			throw MBCoreDataError.notAStore
		}
	}
	
	private func migrateStore(from sMom: NSManagedObjectModel, to dMom: NSManagedObjectModel) throws {
		// Prepare temporary directory
		let dir = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
		try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true, attributes: nil)
		defer {
			try? FileManager.default.removeItem(at: dir)
		}
		
		// Perform migration
		let mapping = try findMapping(from: sMom, to: dMom)
		let destURL = dir.appendingPathComponent(storeURL.lastPathComponent)
		let manager = NSMigrationManager(sourceModel: sMom, destinationModel: dMom)
		try autoreleasepool {
			try manager.migrateStore(
				from: storeURL,
				sourceType: storeType,
				options: nil,
				with: mapping,
				toDestinationURL: destURL,
				destinationType: storeType,
				destinationOptions: nil
			)
		}
		
		// Replace source store
		let psc = NSPersistentStoreCoordinator(managedObjectModel: dMom)
		try psc.replacePersistentStore(
			at: storeURL,
			destinationOptions: nil,
			withPersistentStoreFrom: destURL,
			sourceOptions: nil,
			ofType: storeType
		)
	}
	
	private func findMapping(from sMom: NSManagedObjectModel, to dMom: NSManagedObjectModel) throws -> NSMappingModel {
		// Search for custom mapping models
		if let mapping = NSMappingModel(from: mappingBundles, forSourceModel: sMom, destinationModel: dMom) {
			return mapping
		}
		
		return try NSMappingModel.inferredMappingModel(forSourceModel: sMom, destinationModel: dMom)
	}
	
}
