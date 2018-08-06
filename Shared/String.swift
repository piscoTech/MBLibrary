//
//  String.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

private let XMLEntities: [(value: String, escaped: String)] = [("&", "&amp;"), ("<", "&lt;"), (">", "&gt;")]

extension String {
	
	public var isDigit: Bool {
		if self == "" {
			return false
		}
		
		let digit = "0123456789"
		for c in self {
			if digit.range(of: "\(c)") == nil {
				return false
			}
		}
		
		return true
	}
	
	public var isValidEmailAddress: Bool {
		let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
		if let range = self.range(of: emailRegEx, options: .regularExpression) {
			return range.lowerBound == self.startIndex && range.upperBound == self.endIndex
		} else {
			return false
		}
	}
	
	// MARK: - Transform
	
	public func URLEncode() -> String {
		let set = CharacterSet(charactersIn: "=\"#%/<>?@\\^`{|}&").inverted
		return self.addingPercentEncoding(withAllowedCharacters: set)!
	}
	
	public func toXML() -> String {
		var res = self
		for (from, to) in XMLEntities {
			res = res.replacingOccurrences(of: from, with: to)
		}
		
		return res
	}
	
	public func fromXML() -> String {
		var res = self
		for (from, to) in XMLEntities {
			res = res.replacingOccurrences(of: to, with: from)
		}
		
		return res
	}
	
	public func toCSV() -> String {
		return "\"\(self.replacingOccurrences(of: "\"", with: "\"\""))\""
	}
	
	public func toDouble() -> Double? {
		var s = self
		
		var sign = ""
		if s != "" {
			if s[0] == "+" {
				s = s[1...]
			}
			
			if s[0] == "-" {
				s = s[1...]
				sign = "-"
			}
		}
		
		if s != "" && s[0] == String.decimalPoint {
			s = "0" + s
		}
		
		s = sign + s
		
		return NumberFormatter().number(from: s)?.doubleValue
	}
	
	// MARK: - Substring
	
	public subscript (i: Int) -> String {
		let j = i < 0 ? self.count + i : i
		return String(Array(self)[j])
	}
	
	///Element at last index _is not_ included.
	public subscript (r: CountableRange<Int>) -> String {
		let start = self.index(startIndex, offsetBy: r.lowerBound)
		let end = self.index(startIndex, offsetBy: r.upperBound)
		
		return String(self[start ..< end])
	}
	
	///Element at last index _is_ included.
	public subscript (r: CountableClosedRange<Int>) -> String {
		let start = self.index(startIndex, offsetBy: r.lowerBound)
		let end = self.index(startIndex, offsetBy: r.upperBound)
		
		return String(self[start ... end])
	}
	
	public subscript (r: CountablePartialRangeFrom<Int>) -> String {
		let i = r.lowerBound
		let j = i < 0 ? self.count + i : i
		
		return String(self[self.index(startIndex, offsetBy: j)...])
	}
	
	///Element at last index _is not_ included.
	public subscript (r: PartialRangeUpTo<Int>) -> String {
		let i = r.upperBound
		let j = i < 0 ? self.count + i : i
		
		return String(self[..<self.index(startIndex, offsetBy: j)])
	}
	
	///Element at last index _is_ included.
	public subscript (r: PartialRangeThrough<Int>) -> String {
		let i = r.upperBound
		let j = i < 0 ? self.count + i : i
		
		return String(self[...self.index(startIndex, offsetBy: j)])
	}
	
	private static let nFormat: NumberFormatter = {
		let nFormat = NumberFormatter()
		nFormat.numberStyle = .decimal
		
		return nFormat
	}()
	
	// MARK: - Constants
	
	public static var decimalPoint: String {
		get {
			return nFormat.string(from: 0.1)![1]
		}
	}
	
	public static var CSVSeparator: String {
		return ","
	}
	
}
