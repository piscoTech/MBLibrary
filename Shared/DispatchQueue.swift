//
//  DispatchQueue.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension DispatchQueue {
	
	/// The default global queue with `background` priority.
	public static let background = DispatchQueue.global(qos: .background)
	/// The default global queue with `userInitiated` priority. Use it for task initiated by the user that requires immediate results or continuous user interaction.
	public static let userInitiated = DispatchQueue.global(qos: .userInitiated)
	/// The default global queue with `userInitiated` priority. Use it for task initiated by the user that needs to be done immediately, the amount of work in this queue should be minimal.
	public static let userInteractive = DispatchQueue.global(qos: .userInteractive)
	
	public func asyncAfter(delay t: Double, closure: @escaping () -> Void) {
		self.asyncAfter(deadline: DispatchTime.now() + t, execute: closure)
	}
	
}
