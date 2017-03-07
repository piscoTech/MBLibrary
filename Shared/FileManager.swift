//
//  FileManager.swift
//  MBLibrary
//
//  Created by Marco Boschi on 07/03/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import Foundation

extension FileManager {
	
	public func emptyDirectory(at url: URL) throws {
		let files = try contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
		for f in files {
			try removeItem(at: f)
		}
	}

}
