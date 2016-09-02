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
		if let _ = self.index(of: el) {
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
		
		while let i = self.index(of: el) {
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
			if before.index(of: self[i]) != nil {
				self.remove(at: i)
			} else {
				i += 1
			}
		}
	}
	
}

// MARK: - Random access

extension Array {
	
	mutating public func shuffle() {
		self = self.shuffled()
	}
	
	public func shuffled() -> [Element] {
		var res = [Element]()
		var indices = [Int]()
		for i in 0 ..< self.count {
			indices.append(i)
		}
		
		while indices.count > 0 {
			let i = Int.random(to: indices.count)
			let index = indices[i]
			indices.remove(at: i)
			res.append(self[index])
		}
		
		return res
	}
	
	public var random: Element? {
		guard self.count > 0 else {
			return nil
		}
		
		return self[Int.random(to: self.count)]
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
		var res = self.filter { oth.index(of: $0) != nil }
		res.removeDuplicates()
		
		return res
	}
	
	/// Subract the element of the passed array preserving the order, duplicated elements will be removed and only the first one will be kept.
	///
	/// - parameter oth: The other array.
	///
	/// - returns: The difference of arrays elements.
	public func subtract(_ oth: [Element]) -> [Element] {
		var res = self.filter { oth.index(of: $0) == nil }
		res.removeDuplicates()
		
		return res
	}
	
}
