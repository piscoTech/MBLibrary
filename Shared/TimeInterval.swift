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
	
	public func getFormattedDuration() -> String {
		return TimeInterval.durationF.string(from: self)!
	}

	public func getRawDuration() -> String {
		var s = self
		let neg = s < 0
		if neg {
			s *= -1
		}

		let m = floor(s / 60)
		let sec = Int(fmod(s, 60))

		let h = floor(m / 60)
		let min = Int(fmod(m, 60))

		var res = (sec < 10 ? "0" : "") + "\(sec)"
		res = (min < 10 ? "0" : "") + "\(min):" + res
		res = "\(h.toString()):" + res

		return (neg ? "-" : "") + res
	}
	
	public func getUNIXDateTime() -> String {
		let date = Date(timeIntervalSince1970: self)
		
		return date.getUNIXDateTime()
	}
	
	public func getFormattedDateTime() -> String {
		let date = Date(timeIntervalSince1970: self)
		
		return date.getFormattedDate() + " " + date.getFormattedTime()
	}
	
	public func getFormattedDate() -> String {
		let date = Date(timeIntervalSince1970: self)
		
		return date.getFormattedDate()
	}
	
	public func getFormattedTime() -> String {
		let date = Date(timeIntervalSince1970: self)
		
		return date.getFormattedTime()
	}
	
}
