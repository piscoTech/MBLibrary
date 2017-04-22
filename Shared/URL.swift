//
//  URL.swift
//  MBLibrary
//
//  Created by Marco Boschi on 22/04/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import Foundation

extension URL {
	
	public func loadAsXML(validatingWithXSD xsd: URL? = nil) -> XMLNode? {
		guard let res = (self as NSURL).performXMLXPathQuery("/", withXSD: xsd), res.count == 1 else {
			print("Unable to load file")
			
			return nil
		}
		
		guard let root = res.first, root.children.count == 1, let rootEl = root.children.first else {
			print("No root element found or multiple ones")
			
			return nil
		}
		
		return rootEl
	}
	
	public func perform(XMLXPathQuery q: String, validatingWithXSD xsd: URL? = nil) -> [XMLNode]? {
		return (self as NSURL).performXMLXPathQuery(q, withXSD: xsd)
	}
	
}
