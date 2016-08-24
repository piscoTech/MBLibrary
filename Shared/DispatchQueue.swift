//
//  DispatchQueue.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension DispatchQueue {
	
	public static let background = DispatchQueue.global(attributes: .qosBackground)
	
	public func after(delay t: Double, closure: () -> Void) {
		self.after(when: DispatchTime.now() + t, execute: closure)
		
	}
	
}
