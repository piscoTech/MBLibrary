//
//  WeakReference.swift
//  MBLibrary
//
//  Created by Marco Boschi on 25/06/2019.
//  Copyright © 2019 Marco Boschi. All rights reserved.
//

import Foundation

public protocol WeaklyReference {

	associatedtype Value: AnyObject
	var value: Value? { get }

}

public class WeakReference<T>: WeaklyReference where T: AnyObject {

	public private(set) weak var value: T?

	public init(_ value: T?) {
		self.value = value
	}

}
