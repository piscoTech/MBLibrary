//
//  Main.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

var rngSeeded = false
func seedRng(_ s: Int? = nil, forceSeed force: Bool = false) {
	if rngSeeded && !force {
		return
	}
	
	srand48(s ?? Int(Date().timeIntervalSince1970))
	rngSeeded = true
}

public var decimalPoint: String { return String.decimalPoint }
public var CSVSeparator: String { return String.CSVSeparator }

public protocol Animatable: class {
	
	func startAnimation()
	func stopAnimation()
	func isAnimating() -> Bool
	
}

///Returns a localized string from the MBLibrary framework bundle.
public func MBLocalizedString(_ key: String, comment: String) -> String {
	//Use any class from the framework included in all targets
	let bundle = Bundle(for: KeyValueStore.self)
	return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: comment)
}

public let isiOS: Bool = {
	#if os(iOS)
		return true
	#else
		return false
	#endif
}()

public let ismacOS: Bool = {
	#if os(OSX)
		return true
	#else
		return false
	#endif
}()

public let iswatchOS: Bool = {
	#if os(watchOS)
		return true
	#else
		return false
	#endif
}()
