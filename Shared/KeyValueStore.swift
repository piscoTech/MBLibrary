//
//  KeyValueStore.swift
//  WorkTime
//
//  Created by Marco Boschi on 23/08/15.
//  Copyright © 2015 Marco Boschi. All rights reserved.
//

import Foundation

public typealias KeyValueStoreKey = CustomStringConvertible

public class KeyValueStore {
	
	private var isLocal: Bool
	private var localStore: UserDefaults!
	private var remoteStore: NSUbiquitousKeyValueStore!
	
	public init(iCloudStore: NSUbiquitousKeyValueStore) {
		isLocal = false
		remoteStore = iCloudStore
	}
	
	public init(userDefaults: UserDefaults) {
		isLocal = true
		localStore = userDefaults
	}
	
	public var store: AnyObject {
		get {
			return isLocal ? localStore : remoteStore
		}
	}
	
	// MARK: - Setter
	
	public func set(_ value: Bool, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			remoteStore.set(value, forKey: key)
		}
	}
	
	public func set(_ value: Int, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			remoteStore.set(Int64(value), forKey: key)
		}
	}
	
	public func set(_ value: Double, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			remoteStore.set(value, forKey: key)
		}
	}
	
	public func set(_ value: String, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			remoteStore.set(value, forKey: key)
		}
	}
	
	public func set(_ value: [AnyObject], forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			remoteStore.set(value, forKey: key)
		}
	}
	
	public func set(_ value: [String: AnyObject], forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			remoteStore.set(value, forKey: key)
		}
	}
	
	public func set(_ value: Data, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			remoteStore.set(value, forKey: key)
		}
	}
	
	public func set(_ value: URL, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			remoteStore.set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
		}
	}
	
	public func set(_ value: AnyObject, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			remoteStore.set(value, forKey: key)
		}
	}
	
	// MARK: - Getter
	
	public func bool(forKey: KeyValueStoreKey) -> Bool {
		let key = forKey.description
		if isLocal {
			return localStore.bool(forKey: key)
		} else {
			return remoteStore.bool(forKey: key)
		}
	}
	
	public func integer(forKey: KeyValueStoreKey) -> Int {
		let key = forKey.description
		if isLocal {
			return localStore.integer(forKey: key)
		} else {
			return Int(remoteStore.longLong(forKey: key))
		}
	}
	
	public func double(forKey: KeyValueStoreKey) -> Double {
		let key = forKey.description
		if isLocal {
			return localStore.double(forKey: key)
		} else {
			return remoteStore.double(forKey: key)
		}
	}
	
	public func string(forKey: KeyValueStoreKey) -> String? {
		let key = forKey.description
		if isLocal {
			return localStore.string(forKey: key)
		} else {
			return remoteStore.string(forKey: key)
		}
	}
	
	public func array(forKey: KeyValueStoreKey) -> [Any]? {
		let key = forKey.description
		if isLocal {
			return localStore.array(forKey: key)
		} else {
			return remoteStore.array(forKey: key)
		}
	}
	
	public func dictionary(forKey: KeyValueStoreKey) -> [String: Any]? {
		let key = forKey.description
		if isLocal {
			return localStore.dictionary(forKey: key)
		} else {
			return remoteStore.dictionary(forKey: key)
		}
	}
	
	public func data(forKey: KeyValueStoreKey) -> Data? {
		let key = forKey.description
		if isLocal {
			return localStore.data(forKey: key)
		} else {
			return remoteStore.data(forKey: key)
		}
	}
	
	public func url(forKey: KeyValueStoreKey) -> URL? {
		let key = forKey.description
		if isLocal {
			return localStore.url(forKey: key)
		} else {
			if let data = remoteStore.data(forKey: key) {
				return NSKeyedUnarchiver.unarchiveObject(with: data) as? URL
			} else {
				return nil
			}
		}
	}
	
	public func object(forKey: KeyValueStoreKey) -> Any? {
		let key = forKey.description
		if isLocal {
			return localStore.object(forKey: key)
		} else {
			return remoteStore.object(forKey: key)
		}
	}
	
	// MARK: - Manage
	
	public func removeObject(forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.removeObject(forKey: key)
		} else {
			remoteStore.removeObject(forKey: key)
		}
	}
	
	@discardableResult public func synchronize() -> Bool {
		if isLocal {
			return localStore.synchronize()
		} else {
			return remoteStore.synchronize()
		}
	}
	
}
