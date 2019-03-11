//
//  ContactMeViewController.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 06/08/2018.
//  Copyright © 2018 Marco Boschi. All rights reserved.
//

import UIKit

public class ContactMeViewController: UIViewController, UITextViewDelegate {
	
	private static var urlSession: URLSession?
	
	private static func getUrlSession() -> URLSession {
		if let sess = urlSession {
			return sess
		} else {
			let sess = URLSession(configuration: .default)
			urlSession = sess
			
			return sess
		}
	}
	
	public var appName: String!
	
	@IBOutlet private weak var emailField: UITextField!
	@IBOutlet private weak var disclaimerLbl: UILabel!
	@IBOutlet private weak var messageField: UITextView!
	@IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
	
	@IBOutlet private weak var cancelBtn: UIBarButtonItem!
	@IBOutlet private weak var sendBtn: UIBarButtonItem!
	
	private let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
	private let placeHolderColor = #colorLiteral(red: 0.6700000167, green: 0.6700000167, blue: 0.6700000167, alpha: 1)
	private let disclaimerColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
	
	private var placeHolderHidden = false
	private var mailOk = false
	private var textOk = false

	override public func viewDidLoad() {
        super.viewDidLoad()
		
		guard let name = appName, !name.isEmpty else {
			cancel(self)
			
			return
		}
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
		
		messageField.text = MBLocalizedString("MSG_PLACEHOLDER", comment: "Your message")
		
		emailField.textColor = textColor
		disclaimerLbl.textColor = disclaimerColor
		messageField.textColor = placeHolderColor
		
		emailField.keyboardAppearance = .default
		messageField.keyboardAppearance = .default
		
		updateSendButton()
    }
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		emailField.becomeFirstResponder()
	}
	
	// MARK: - Editing management
	
	public func textViewDidBeginEditing(_ textView: UITextView) {
		guard !placeHolderHidden else {
			return
		}
		placeHolderHidden = true
		
		messageField.text = ""
		messageField.textColor = textColor
		
		textOk = false
		updateSendButton()
	}
	
	@objc func keyboardChanged(_ not: Notification) {
		if let kbRect = ((not as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			bottomConstraint.constant = kbRect.height
			UIView.animate(withDuration: 0.25) {
				self.view.layoutIfNeeded()
			}
		}
	}
	
	@objc func keyboardWillHide(_ not: Notification) {
		bottomConstraint.constant = 0
		UIView.animate(withDuration: 0.25) {
			self.view.layoutIfNeeded()
		}
	}
	
	public func textViewDidChange(_ textView: UITextView) {
		textOk = messageField.text.trimmingCharacters(in: .whitespacesAndNewlines) != ""
		updateSendButton()
	}
	
	@IBAction func mailChanged(_ sender: AnyObject) {
		mailOk = emailField.text?.isValidEmailAddress ?? false
		updateSendButton()
	}
	
	// MARK: - Sending
	
	private func updateSendButton() {
		sendBtn.isEnabled = mailOk && textOk
	}
	
	// MARK: - Navigation
	
	@IBAction func cancel(_ sender: AnyObject) {
		self.dismiss(animated: true)
	}
	
	@IBAction func send(_ sender: AnyObject) {
		let fileUrl = URL(string: "https://marcoboschi.altervista.org/sendMail/")!
		
		// Create the request
		let urlRequest = NSMutableURLRequest(url: fileUrl)
		urlRequest.httpMethod = "POST"
		
		let boundary="_Pisco_Tech_App_"
		urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
		
		var param: [String : String] = [
			"fromApp": appName,
			"text": messageField.text.trimmingCharacters(in: .whitespacesAndNewlines),
			"mail": emailField.text ?? ""
		]
		
		var body = NSMutableData()
		
		func addData(_ data: String, to mainData: inout NSMutableData){
			mainData.append(data.data(using: .utf8)!)
		}
		
		for p in param {
			addData("\r\n--\(boundary)\r\n", to: &body)
			addData("Content-Disposition: form-data; name=\"\(p.0)\"\r\n\r\n\(p.1)", to: &body)
		}
		
		addData("\r\n--\(boundary)\r\n", to: &body)
		urlRequest.httpBody = body as Data
		
		sendBtn.isEnabled = false
		cancelBtn.isEnabled = false
		messageField.isEditable = false
		emailField.isEnabled = false
		
		let loading = UIAlertController.getModalLoading()
		present(loading, animated: true)
		
		let sendMsg = ContactMeViewController.getUrlSession().dataTask(with: urlRequest as URLRequest) { (data, _, err) in
			DispatchQueue.main.async {
				loading.dismiss(animated: true) {
					guard err == nil, let data = data, let res = String(data: data, encoding: .utf8), res == "ok" else {
						let alert = UIAlertController(simpleAlert: MBLocalizedString("ERROR", comment: "Error"), message: MBLocalizedString("CANT_SEND_CONTACT_MSG", comment: "Can't send"))
						self.present(alert, animated: true)
						
						self.cancelBtn.isEnabled = true
						self.messageField.isEditable = true
						self.emailField.isEnabled = true
						self.updateSendButton()
						
						return
					}
					
					self.dismiss(animated: true)
				}
			}
		}
		sendMsg.resume()
	}
	
}
