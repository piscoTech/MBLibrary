//
//  String.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

extension String {
		
	public var length: Int {
		get {
			return self.characters.count
		}
	}
	
	public func URLEncode() -> String {
		let set = CharacterSet(charactersIn: "=\"#%/<>?@\\^`{|}&").inverted
		return self.addingPercentEncoding(withAllowedCharacters: set)!
	}
	
	public func toCSV() -> String {
		return "\"\(self.replacingOccurrences(of: "\"", with: "\"\""))\""
	}
	
	// MARK: - Substring
	
	public subscript (i: Int) -> String {
		let j = i < 0 ? self.characters.count + i : i
		return String(Array(self.characters)[j])
	}
	
	///Element at last index is _not_ included.
	public subscript (r: CountableRange<Int>) -> String {
		return substring(with: r)
	}
	
	///Element at last index is _not_ included.
	public func substring(with r: CountableRange<Int>) -> String {
		let start = self.index(startIndex, offsetBy: r.lowerBound)
		let end = self.index(startIndex, offsetBy: r.upperBound)
		
		return substring(with: start ..< end)
	}
	
	public func substring(from i: Int) -> String {
		let j = i < 0 ? self.characters.count + i : i
		return substring(from: self.index(startIndex, offsetBy: j))
	}
	
	public func substring(to i: Int) -> String {
		let j = i < 0 ? self.characters.count + i : i
		return substring(to: self.index(startIndex, offsetBy: j))
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
