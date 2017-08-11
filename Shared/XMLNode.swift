//
//  XMLNode.swift
//  MBLibrary
//
//  Created by Marco Boschi on 22/04/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import Foundation

@objc public class XMLNode: NSObject {
	
	@objc public let name: String
	
	@objc public private(set) var content: String?
	public private(set) var attributes: [String: String]
	public private(set) var children: [XMLNode]
	
	private override init() {
		fatalError("Initialize with init(name:)")
	}
	
	@objc init(name: String) {
		self.name = name
		
		children = []
		attributes = [:]
	}
	
	@objc func set(content s: String?) {
		self.content = s
	}
	
	@objc func add(attribute a: String, withValue v: String) {
		attributes[a] = v
	}
	
	@objc func add(child c: XMLNode) {
		children.append(c)
	}
	
}
