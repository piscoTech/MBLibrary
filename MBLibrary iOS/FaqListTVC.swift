//
//  FaqListTableViewController.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 07/08/18.
//  Copyright © 2018 Marco Boschi. All rights reserved.
//

import UIKit

public class FaqListTableViewController: UITableViewController {
	
	public var faqController: FAQController!

	override public func viewDidLoad() {
		super.viewDidLoad()
	}

	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override public func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return faqController.FAQs.count
	}
	
	override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "faq")!
		let faqID = faqController.FAQs[indexPath.row]
		
		cell.textLabel!.text = faqController.get(faqID)!.longTitle
		cell.tag = faqController.tagForID(faqID)!
		
		return cell
	}

	// MARK: - Navigation

	override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showFAQ",
			let faq = sender as? UITableViewCell,
			let index = tableView.indexPath(for: faq) {
			let dest = segue.destination as! ShowFaqViewController
			dest.faqID = faqController.FAQs[index.row]
			dest.faqController = faqController
		}
	}

}
