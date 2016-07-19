//
//  Double.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension Double {
	
	public func toCSV() -> String {
		var n = "\(self)"
		
		if let point = n.range(of: ".") {
			n = n.replacingCharacters(in: point, with: decimalPoint)
		}
		
		return n.toCSV()
	}
	
}
