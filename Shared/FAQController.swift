//
//  FAQController.swift
//  MBLibrary
//
//  Created by Marco Boschi on 22/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

public class FAQController {
	
	private static let errorIndex = 0
	
	private let bundle: Bundle
	private let FAQ: [Int: String]
	public let order: [Int]
	public var baseTag = 0
	public var prefix = ""
	
	///Manages FAQs using the specified list searching the appropriate HTML file in the passed bundle.
	///
	///- parameter faqList: The FAQ represented by an integer id and the key used the get the localized title.
 	///- parameter b: The bundle containing the HTML files for the FAQs and localization data for their titles.
	public init(faqList: [Int: String], inBundle b: Bundle, withOrder order: [Int]? = nil) {
		FAQ = faqList
		bundle = b
		
		let faqIDs = Array(FAQ.keys).sorted()
		self.order = (order ?? faqIDs).intersect(faqIDs).union(faqIDs)
	}
	
	private lazy var data: [Int: (longTitle: String, title: String, url: URL)] = {
		var d = [Int: (longTitle: String, title: String, url: URL)]()
		
		d[FAQController.errorIndex] = ("Error", "Error", self.bundle.url(forResource: "FAQ_Error", withExtension: "html")!)
		for (n, title) in self.FAQ {
			guard let url = self.bundle.url(forResource: "FAQ_\(n)", withExtension: "html") else {
				continue
			}
			
			let longTitle = NSLocalizedString(self.prefix + title + "_LONG", bundle: self.bundle, comment: "FAQ Title")
			let title = NSLocalizedString(self.prefix + title, bundle: self.bundle, comment: "FAQ Title")
			d[n] = (longTitle, title, url)
		}
		
		return d
	}()
	
	public func get(_ faq: Int) -> (longTitle: String, title: String, url: URL)? {
		guard let _ = FAQ[faq] else {
			return nil
		}
		
		return data[faq]
	}
	
	public var error: URL {
		return data[FAQController.errorIndex]!.url
	}
	
	public func tagForID(_ id: Int) -> Int? {
		if let _ = FAQ[id] {
			return id + baseTag
		} else {
			return nil
		}
	}
	
	public func idFromTag(_ id: Int) -> Int? {
		let decoded = id - baseTag
		if let _ = FAQ[decoded] {
			return decoded
		} else {
			return nil
		}
	}
	
}
