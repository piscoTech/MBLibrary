//
//  Date.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension Date {
	
	private static let unixDateTimeF = { Void -> DateFormatter in
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm"
		
		return formatter
	}()
	
	private static let localDateF = { Void -> DateFormatter in
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .none
		
		return formatter
	}()
	
	private static let localTimeF = { Void -> DateFormatter in
		let formatter = DateFormatter()
		formatter.dateStyle = .none
		formatter.timeStyle = .short
		
		return formatter
	}()
	
	public func getUNIXDateTime() -> String {
		return Date.unixDateTimeF.string(from: self)
	}
	
	public func getFormattedDateTime() -> String {
		return getFormattedDate() + " " + getFormattedTime()
	}
	
	public func getFormattedDate() -> String {
		return Date.localDateF.string(from: self)
	}
	
	public func getFormattedTime() -> String {
		return Date.localTimeF.string(from: self)
	}
	
}
