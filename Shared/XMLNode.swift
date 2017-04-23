//
//  XMLNode.swift
//  MBLibrary
//
//  Created by Marco Boschi on 22/04/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import Foundation

@objc public class XMLNode: NSObject {
	
	public let name: String
	
	public private(set) var content: String?
	public private(set) var attributes: [String: String]
	public private(set) var children: [XMLNode]
	
	private override init() {
		fatalError("Initialize with init(name:)")
	}
	
	init(name: String) {
		self.name = name
		
		children = []
		attributes = [:]
	}
	
	func set(content s: String?) {
		self.content = s
	}
	
	func add(attribute a: String, withValue v: String) {
		attributes[a] = v
	}
	
	func add(child c: XMLNode) {
		children.append(c)
	}
	
}
