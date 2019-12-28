//
//  TimeInterval.swift
//  Workout
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension TimeInterval {

	private static let durationF: DateComponentsFormatter = {
		let formatter = DateComponentsFormatter()
		formatter.unitsStyle = .abbreviated
		formatter.zeroFormattingBehavior = .default

		return formatter
	}()
	
	public var formattedDuration: String {
		Self.durationF.string(from: self)!
	}

	public func rawDuration(hidingHours shouldHide: Bool = false) -> String {
		var s = self
		let neg = s < 0
		if neg {
			s *= -1
		}

		let m = floor(s / 60)
		let sec = Int(fmod(s, 60))

		let h = floor(m / 60)
		let min = Int(fmod(m, 60))
		let doHide = shouldHide && h == 0

		var res = (sec < 10 ? "0" : "") + "\(sec)"
		res = (min < 10 && !doHide ? "0" : "") + "\(min):" + res
		res = (doHide ? "" : "\(h.toString()):") + res

		return (neg ? "-" : "") + res
	}

	/// The representation in the local time zone in the format `YYYY-MM-DD HH:mm` of the date created by interpreting the receiver as the number of seconds from January 1, 1970 00:00:00 UTC.
	public var unixDateTime: String {
		let date = Date(timeIntervalSince1970: self)
		
		return date.unixDateTime
	}

	/// The representation in the local time zone and current locale of the date and time created by interpreting the receiver as the number of seconds from January 1, 1970 00:00:00 UTC.
	public var formattedDateTime: String {
		let date = Date(timeIntervalSince1970: self)
		
		return date.formattedDate
	}

	/// The representation in the local time zone and current locale of the date created by interpreting the receiver as the number of seconds from January 1, 1970 00:00:00 UTC.
	public var formattedDate: String {
		let date = Date(timeIntervalSince1970: self)
		
		return date.formattedDate
	}

	/// The representation in the local time zone and current locale of the time created by interpreting the receiver as the number of seconds from January 1, 1970 00:00:00 UTC.
	public var formattedTime: String {
		let date = Date(timeIntervalSince1970: self)
		
		return date.formattedTime
	}
	
}
