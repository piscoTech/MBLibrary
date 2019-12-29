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

	private static let unixTimestampF: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

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

	private static let utcF: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
		formatter.timeZone = TimeZone(abbreviation: "UTC")

		return formatter
	}()

	private static let utcIsoF: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
		formatter.timeZone = TimeZone(abbreviation: "UTC")

		return formatter
	}()

	/// The representation of the receiver in the local time zone in the format `YYYY-MM-DD HH:mm`.
	public var unixDateTime: String {
		Self.unixDateTimeF.string(from: self)
	}

	/// The representation of the receiver in the local time zone in the format `YYYY-MM-DD HH:mm:ss.sss`.
	public var unixTimestamp: String {
		Self.unixTimestampF.string(from: self)
	}

	/// The representation of the receiver in the local time zone and current locale.
	public var formattedDateTime: String {
		"\(formattedDate) \(formattedTime)"
	}

	/// The representation of the receiver date in the local time zone and current locale.
	public var formattedDate: String {
		Self.localDateF.string(from: self)
	}

	/// The representation of the receiver time in the local time zone and current locale.
	public var formattedTime: String {
		Self.localTimeF.string(from: self)
	}

	/// The representation of the receiver in UTC in the format `YYYY-MM-DD HH:mm:ss.sss`.
	public var utcTimestamp: String {
		Self.utcF.string(from: self)
	}

	/// The representation of the receiver in UTC according to ISO 8601 specification, e.g. `2019-12-22T14:54:35.536Z`.
	public var utcISOdescription: String {
		Self.utcIsoF.string(from: self)
	}

	// MARK: - Handling

	public enum RoundingPrecision {
		case day, minute
	}

	public func round(to precision: RoundingPrecision = .day, keepTimeZone: Bool = false) -> Date {
		var components: Set<Calendar.Component> = [.calendar]
		switch precision {
		case .minute:
			components.formUnion([.minute, .hour])
			fallthrough
		case .day:
			components.formUnion([.day, .month, .year, .era])
		}
		if keepTimeZone {
			components.insert(.timeZone)
		}
		
		let calendar = Calendar.current
		let comp = calendar.dateComponents(components, from: self)
		
		return calendar.date(from: comp)!
	}
	
}
