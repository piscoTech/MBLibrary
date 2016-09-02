//
//  Bundle.swift
//  MBLibrary
//
//  Created by Marco Boschi on 31/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension Bundle {
	
	public var versionInfo: (version: String, build: String) {
		let version = (self.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "0.0"
		let build = (self.object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? "0"
		
		return (version, build)
	}
	
}
