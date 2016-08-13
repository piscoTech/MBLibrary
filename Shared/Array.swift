//
//  Array.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

public protocol Sortable {
	
	func sortBefore(_ oth: Self) -> Bool
	
}

extension Array where Element: Sortable {
	
	///Returns a sorted copy of the collection using the criteria provided by its elements.
	public func sorted() -> [Element] {
		return self.sorted { $0.sortBefore($1) }
	}
	
	///Sorts the collection using the criteria provided by its elements.
	mutating public func sort() {
		self.sort { $0.sortBefore($1) }
	}
	
}

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
	
}

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
	
}
