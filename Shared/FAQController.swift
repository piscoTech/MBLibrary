//
//  FAQController.swift
//  MBLibrary
//
//  Created by Marco Boschi on 22/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation

/// Manages a list FAQs expecting to find in the given bundle HTML files named `FAQ_n.html`, localized names by the keys `FAQ_n` and `FAQ_n_LONG` respectively for the name to display when viewing the FAQ and in the list, `n` is the FAQ id.
public class FAQController {
	
	public typealias FAQData = (longTitle: String, title: String, url: URL)
	
	private static let errorIndex = 0
	
	private let bundle: Bundle
	/// The ordered list of FAQ ids.
	public let FAQs: [Int]
	/// When requesting the tag (to use for the view representing the FAQ in the list) this will be summed to the FAQ id.
	public var baseTag = 0
	
	/// Manages FAQs using the specified list searching the appropriate HTML file in the passed bundle.
	///
	///- parameter count: How many FAQs are available, their ids and order will be given by the range `1 ... count`.
 	///- parameter b: The bundle containing the HTML files for the FAQs and localization data for their titles.
	public convenience init(count: Int, inBundle b: Bundle = Bundle.main) {
		self.init(list: Array(1 ... count), inBundle: b)
	}
	
	/// Manages FAQs using the specified list searching the appropriate HTML file in the passed bundle.
	///
	///- parameter ids: The list of FAQ ids, the FAQs will be displayed in the given order.
	///- parameter b: The bundle containing the HTML files for the FAQs and localization data for their titles.
	public init(list ids: [Int], inBundle b: Bundle = Bundle.main) {
		FAQs = ids
		bundle = b
	}
	
	private lazy var data: [Int: FAQData] = {
		var d = [Int: FAQData]()
		
		d[FAQController.errorIndex] = ("Error", "Error", self.bundle.url(forResource: "FAQ_Error", withExtension: "html")!)
		for fId in self.FAQs {
			guard let url = self.bundle.url(forResource: "FAQ_\(fId)", withExtension: "html") else {
				continue
			}
			
			let longTitle = NSLocalizedString("FAQ_\(fId)_LONG", bundle: self.bundle, comment: "FAQ Title")
			let title = NSLocalizedString("FAQ_\(fId)", bundle: self.bundle, comment: "FAQ Title")
			d[fId] = (longTitle, title, url)
		}
		
		return d
	}()
	
	public func get(_ faq: Int) -> FAQData? {
		return data[faq]
	}
	
	public var error: URL {
		return data[FAQController.errorIndex]!.url
	}
	
	public func tagForID(_ id: Int) -> Int? {
		if FAQs.contains(id) {
			return id + baseTag
		} else {
			return nil
		}
	}
	
	public func idFromTag(_ tag: Int) -> Int? {
		let decoded = tag - baseTag
		if FAQs.contains(decoded) {
			return decoded
		} else {
			return nil
		}
	}
	
}
