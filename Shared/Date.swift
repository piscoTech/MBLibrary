//
//  Date.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension Date {

	// MARK: - Formatting
	
	private static let unixDateTimeF: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm"
		
		return formatter
	}()
	
	private static let localDateF: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .none
		
		return formatter
	}()
	
	private static let localTimeF: DateFormatter = {
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

	// MARK: - Handling

	public func removingTime(keepTimeZone: Bool = false) -> Date {
		var additionalComponents: Set<Calendar.Component> = []
		if keepTimeZone {
			additionalComponents.insert(.timeZone)
		}

		let calendar = Calendar.current
		let comp = calendar.dateComponents(Set([Calendar.Component.era, .year, .month, .day, .calendar]).union(additionalComponents), from: self)

		return calendar.date(from: comp)!
	}
	
}
