//
//  TimeInterval.swift
//  Workout
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension TimeInterval {
	
	public func getDuration(hideHours shouldHide: Bool = false) -> String {
		var s = Int(floor(self))
		let neg = s < 0
		if neg {
			s *= -1
		}
		
		var m = s / 60
		s = s % 60
		
		let h = m / 60
		m = m % 60
		let doHide = shouldHide && h == 0
		
		let sec = (s < 10 ? "0" : "") + "\(s)"
		let min = (m < 10 && !doHide ? "0" : "") + "\(m)"
		let hour = doHide ? "" : "\(h):"
		
		return (neg ? "-" : "") + "\(hour)\(min):\(sec)"
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
