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
	
	///Manages FAQs using the specified list searching the appropriate HTML file in the passed bundle.
	///
	///- parameter faqList: The FAQ represented by an integer id and the key used the get the localized title.
 	///- parameter b: The bundle containing the HTML files for the FAQs and localization data for their titles.
	public init(faqList: [Int: String], inBundle b: Bundle) {
		FAQ = faqList
		bundle = b
	}
	
	private lazy var data: [Int: (title: String, url: URL)] = {
		var d = [Int: (title: String, url: URL)]()
		
		d[FAQController.errorIndex] = ("Error", self.bundle.url(forResource: "FAQ_Error", withExtension: "html")!)
		for (n, title) in self.FAQ {
			guard let url = self.bundle.url(forResource: "FAQ_\(n)", withExtension: "html") else {
				continue
			}
			
			d[n] = (NSLocalizedString(title, bundle: self.bundle, comment: "FAQ Title"), url)
		}
		
		return d
	}()
	
	public func get(_ faq: Int) -> (title: String, url: URL)? {
		guard let _ = FAQ[faq] else {
			return nil
		}
		
		return data[faq]
	}
	
	public var error: URL {
		return data[FAQController.errorIndex]!.url
	}
	
}
