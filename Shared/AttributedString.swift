//
//  AttributedString.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 14/07/2019.
//  Copyright © 2019 Marco Boschi. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
	
	/// Replaces the first instance of the given string.
	/// - note: This function is based on `replaceCharacters(in: _, with: _)`. See its documentation for details on how replacement is carried out.
	/// - parameter search: The string to be replaced.
	/// - parameter replace: The string to use as replacement if an occurence is found.
	public func replace(_ search: String, with replace: String) {
		self.replace(search, with: NSAttributedString(string: replace))
	}
	
	/// Replaces the first instance of the given string.
	/// - note: This function is based on `replaceCharacters(in: _, with: _)`. See its documentation for details on how replacement is carried out.
	/// - parameter search: The string to be replaced.
	/// - parameter replace: The string to use as replacement if an occurence is found.
	public func replace(_ search: String, with replace: NSAttributedString) {
		let raw = self.string
		if let range = raw.range(of: search) {
			let r = NSRange(range, in: raw)
			self.replaceCharacters(in: r, with: replace)
		}
	}
	
}
