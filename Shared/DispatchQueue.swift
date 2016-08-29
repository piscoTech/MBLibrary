//
//  DispatchQueue.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension DispatchQueue {
	
	public static let background = DispatchQueue.global(qos: .background)
	
	public func asyncAfter(delay t: Double, closure: @escaping () -> Void) {
		self.asyncAfter(deadline: DispatchTime.now() + t, execute: closure)
//		self.after(when: DispatchTime.now() + t, execute: closure)
	}
	
}
