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
	
	#if !os(watchOS)
	private var remoteStore: NSUbiquitousKeyValueStore!
	
	public init(iCloudStore: NSUbiquitousKeyValueStore) {
		isLocal = false
		remoteStore = iCloudStore
	}
	#endif
	
	public init(userDefaults: UserDefaults) {
		isLocal = true
		localStore = userDefaults
	}
	
	public var store: AnyObject {
		#if !os(watchOS)
			return isLocal ? localStore : remoteStore
		#else
			return localStore
		#endif
	}
	
	// MARK: - Setter
	
	public func set(_ value: Bool, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.set(value, forKey: key)
			#endif
		}
	}
	
	public func set(_ value: Int, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.set(Int64(value), forKey: key)
			#endif
		}
	}
	
	public func set(_ value: Double, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.set(value, forKey: key)
			#endif
		}
	}
	
	public func set(_ value: String, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.set(value, forKey: key)
			#endif
		}
	}
	
	public func set(_ value: [AnyObject], forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.set(value, forKey: key)
			#endif
		}
	}
	
	public func set(_ value: [String: AnyObject], forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.set(value, forKey: key)
			#endif
		}
	}
	
	public func set(_ value: Data, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.set(value, forKey: key)
			#endif
		}
	}
	
	public func set(_ value: URL, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
			#endif
		}
	}
	
	public func set(_ value: Any, forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.set(value, forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.set(value, forKey: key)
			#endif
		}
	}
	
	// MARK: - Getter
	
	public func bool(forKey: KeyValueStoreKey) -> Bool {
		let key = forKey.description
		if isLocal {
			return localStore.bool(forKey: key)
		} else {
			#if !os(watchOS)
				return remoteStore.bool(forKey: key)
			#else
				return false
			#endif
		}
	}
	
	public func integer(forKey: KeyValueStoreKey) -> Int {
		let key = forKey.description
		if isLocal {
			return localStore.integer(forKey: key)
		} else {
			#if !os(watchOS)
				return Int(remoteStore.longLong(forKey: key))
			#else
				return 0
			#endif
		}
	}
	
	public func double(forKey: KeyValueStoreKey) -> Double {
		let key = forKey.description
		if isLocal {
			return localStore.double(forKey: key)
		} else {
			#if !os(watchOS)
				return remoteStore.double(forKey: key)
			#else
				return 0
			#endif
		}
	}
	
	public func string(forKey: KeyValueStoreKey) -> String? {
		let key = forKey.description
		if isLocal {
			return localStore.string(forKey: key)
		} else {
			#if !os(watchOS)
				return remoteStore.string(forKey: key)
			#else
				return nil
			#endif
		}
	}
	
	public func array(forKey: KeyValueStoreKey) -> [Any]? {
		let key = forKey.description
		if isLocal {
			return localStore.array(forKey: key)
		} else {
			#if !os(watchOS)
				return remoteStore.array(forKey: key)
			#else
				return nil
			#endif
		}
	}
	
	public func dictionary(forKey: KeyValueStoreKey) -> [String: Any]? {
		let key = forKey.description
		if isLocal {
			return localStore.dictionary(forKey: key)
		} else {
			#if !os(watchOS)
				return remoteStore.dictionary(forKey: key)
			#else
				return nil
			#endif
		}
	}
	
	public func data(forKey: KeyValueStoreKey) -> Data? {
		let key = forKey.description
		if isLocal {
			return localStore.data(forKey: key)
		} else {
			#if !os(watchOS)
				return remoteStore.data(forKey: key)
			#else
				return nil
			#endif
		}
	}
	
	public func url(forKey: KeyValueStoreKey) -> URL? {
		let key = forKey.description
		if isLocal {
			return localStore.url(forKey: key)
		} else {
			let def: URL? = nil
			#if !os(watchOS)
				if let data = remoteStore.data(forKey: key) {
					return NSKeyedUnarchiver.unarchiveObject(with: data) as? URL
				} else {
					return def
				}
			#else
				return def
			#endif
		}
	}
	
	public func object(forKey: KeyValueStoreKey) -> Any? {
		let key = forKey.description
		if isLocal {
			return localStore.object(forKey: key)
		} else {
			#if !os(watchOS)
				return remoteStore.object(forKey: key)
			#else
				return nil
			#endif
		}
	}
	
	// MARK: - Manage
	
	public func removeObject(forKey: KeyValueStoreKey) {
		let key = forKey.description
		if isLocal {
			localStore.removeObject(forKey: key)
		} else {
			#if !os(watchOS)
				remoteStore.removeObject(forKey: key)
			#endif
		}
	}
	
	@discardableResult public func synchronize() -> Bool {
		if isLocal {
			return localStore.synchronize()
		} else {
			#if !os(watchOS)
				return remoteStore.synchronize()
			#else
				return false
			#endif
		}
	}
	
}

