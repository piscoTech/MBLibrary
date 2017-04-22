//
//  XMLElements.swift
//  MBLibrary
//
//  Created by Marco Boschi on 22/04/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import Foundation

@objc public class XMLNode: NSObject {
	
	public let name: String
	
	public private(set) var content: String?
	public private(set) var attributes: [XMLAttribute]
	public private(set) var children: [XMLNode]
	
	private override init() {
		fatalError("Initialize with init(name:)")
	}
	
	init(name: String) {
		self.name = name
		
		children = []
		attributes = []
	}
	
	func set(content s: String?) {
		self.content = s
	}
	
	func add(attribute a: XMLAttribute) {
		attributes.append(a)
	}
	
	func add(child c: XMLNode) {
		children.append(c)
	}
	
}

@objc public class XMLAttribute: NSObject {
	
	public let name, value: String
	
	private override init() {
		fatalError("Initialize with init(name:value:)")
	}
	
	init(name: String, value: String) {
		self.name = name
		self.value = value
	}
	
}
