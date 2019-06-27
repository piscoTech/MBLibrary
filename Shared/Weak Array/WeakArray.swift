//
//  WeakArray.swift
//  MBLibrary
//
//  Created by Marco Boschi on 25/06/2019.
//  Copyright © 2019 Marco Boschi. All rights reserved.
//

import Foundation

extension Array where Element: WeaklyReference {

	public mutating func compact() {
		self = self.filter { $0.value != nil }
	}

}
