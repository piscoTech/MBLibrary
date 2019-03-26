//
//  Array.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

// MARK: - Operation with elements

extension Array where Element: Equatable {
	
	///Appends the passed elements if and only if it isn't already inside the array.
	///- returns: Whether or not the insertions succeded.
	@discardableResult mutating public func appendUnique(_ el: Element) -> Bool {
		if let _ = self.firstIndex(of: el) {
			return false
		} else {
			self.append(el)
			
			return true
		}
	}
	
	///Remove the specified element from the array.
	///- returns: How many times the element has been found and deleted.
	@discardableResult mutating public func removeElement(_ el: Element) -> Int {
		var count = 0
		
		while let i = self.firstIndex(of: el) {
			remove(at: i)
			count += 1
		}
		
		return count
	}
	
	/// Modify the array leaving only the first instance of duplicated elements.
	mutating public func removeDuplicates() {
		var i = 0
		
		while i < self.count {
			let before = Array(self[0 ..< i])
			if before.firstIndex(of: self[i]) != nil {
				self.remove(at: i)
			} else {
				i += 1
			}
		}
	}
	
	/// Return a copy of the array leaving only the first instance of duplicated elements.
	public func removingDuplicates() -> [Element] {
		var copy = self
		copy.removeDuplicates()
		
		return copy
	}
	
}

extension Array where Element: Hashable {
	
	/// The mode of the array, that is the most frequent element or `nil` if the array is empty.
	public var mode: Element? {
		guard let f = self.first else {
			return nil
		}
		
		var counter = [Element: Int]()
		var max = 0
		var mode = f
		
		for e in self {
			let count = (counter[e] ?? 0) + 1
			counter[e] = count
			
			if count > max {
				mode = e
				max = count
			}
		}
		
		return mode
	}
	
}

// MARK: - Set operation

extension Array where Element: Equatable {
	
	/// Merge together the elements of two arrays preserving order, duplicated elements will be removed and only the first one will be kept.
	///
	/// - parameter oth: The other array.
	///
	/// - returns: The union of arrays elements.
	public func union(_ oth: [Element]) -> [Element] {
		var res = self + oth
		res.removeDuplicates()
		
		return res
	}
	
	/// Intersect the elements of two arrays preserving the order of the first array, duplicated elements will be removed and only the first one will be kept.
	///
	/// - parameter oth: The other array.
	///
	/// - returns: The intersection of arrays elements.
	public func intersect(_ oth: [Element]) -> [Element] {
		var res = self.filter { oth.firstIndex(of: $0) != nil }
		res.removeDuplicates()
		
		return res
	}
	
	/// Subract the element of the passed array preserving the order, duplicated elements will be removed and only the first one will be kept.
	///
	/// - parameter oth: The other array.
	///
	/// - returns: The difference of arrays elements.
	public func subtract(_ oth: [Element]) -> [Element] {
		var res = self.filter { oth.firstIndex(of: $0) == nil }
		res.removeDuplicates()
		
		return res
	}
	
}

// MARK: - Join elements

extension Array where Element == NSAttributedString {
	
	public func joined() -> NSAttributedString {
		return joined(separator: "")
	}
	
	public func joined(separator: String) -> NSAttributedString {
		return joined(separator: NSAttributedString(string: separator))
	}
	
	public func joined(separator: NSAttributedString) -> NSAttributedString {
		let res = NSMutableAttributedString()
		var addSeparator = false
		
		for s in self {
			if addSeparator {
				res.append(separator)
			} else {
				addSeparator = true
			}
			
			res.append(s)
		}
		
		return res
	}
	
}

