//
//  NSNib.swift
//  MBLibrary macOS
//
//  Created by Marco Boschi on 14/08/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import AppKit

extension NSNib {
	
	public func instantiate(withOwner owner: Any?) -> [Any] {
		var obj: NSArray? = NSArray()
		let res = self.instantiate(withOwner: owner, topLevelObjects: &obj)
		
		return res ? obj as! [Any] : []
	}
	
}
