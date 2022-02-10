//
//  ShowFaqViewController.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 07/08/18.
//  Copyright © 2018 Marco Boschi. All rights reserved.
//

import UIKit
import WebKit

class ShowFaqViewController: UIViewController {
	
	var faqID: Int!
	var faqController: FAQController!
    @IBOutlet private weak var faqView: WKWebView!
	
	private var faqLoaded = false

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = ""
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if faqLoaded { return }
		
		faqLoaded = true
		let url: URL
		if let (_, title, u) = faqController.get(faqID) {
			navigationItem.title = title
			url = u
		} else {
			url = faqController.error
		}
        _ = faqView.load(URLRequest(url: url))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
