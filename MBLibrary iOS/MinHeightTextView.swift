//
//  MinHeightTextView.swift
//  MBLibrary
//
//  Created by Adam on 10/10/13.
//  Translated to Swift by Marco Boschi on 22/07/15.
//  Copyright © 2015 Marco Boschi. All rights reserved.
//

import UIKit

public class MinHeightTextView: UITextView {
	
	private let correctionFactor: CGFloat = 5
	private var heightConstraint: NSLayoutConstraint?
	
	override public var text: String! {
		didSet {
			updatePlaceholderDisplay()
		}
	}
	
	override public func insertText(_ text: String) {
		super.insertText(text)
		
		updatePlaceholder()
	}
	
	override public var attributedText: AttributedString! {
		didSet {
			updatePlaceholder()
		}
	}
	
	override public var contentInset: UIEdgeInsets {
		didSet {
			updatePlaceholder()
		}
	}
	
	override public var font: UIFont? {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	override public var textAlignment: NSTextAlignment {
		didSet {
			updatePlaceholder()
		}
	}

	public var placeholder: String? {
		didSet {
			placeholderView.text = placeholder
			updatePlaceholderDisplay()
		}
	}
	
	private var placeholderView: UILabel = UILabel()
	private var editCorrectionType: UITextAutocorrectionType = .default
	
	public convenience init() {
		self.init(frame: CGRect.zero)
	}
	
	override public init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		
		commonInit()
	}
	
	public convenience init(frame: CGRect) {
		self.init(frame: frame, textContainer: nil)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		commonInit()
	}
	
	private func commonInit() {
		for constraint in constraints {
			if constraint.firstAttribute == NSLayoutAttribute.height
				&& constraint.firstItem as! NSObject == self
				&& constraint.relation == .equal {
				heightConstraint = constraint
				break
			}
		}
		
		layer.borderColor = UIColor(white: 212.0 / 255.0, alpha: 1).cgColor
		layer.cornerRadius = 6
		
		NotificationCenter.default().addObserver(self, selector: #selector(MinHeightTextView.textChanged(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
		
		self.contentInset = UIEdgeInsetsZero
		self.editCorrectionType = self.autocorrectionType
		self.textContainerInset = UIEdgeInsetsZero
		isEditable = false
		
		self.addSubview(placeholderView)
		placeholderView.textColor = UIColor.lightGray()
		placeholderView.lineBreakMode = .byTruncatingTail
	}
	
	deinit {
		NotificationCenter.default().removeObserver(self)
	}
	
	private func updatePlaceholder() {
		let rect = placeholderRectForBounds(self.bounds)
		
		placeholderView.font = self.font
		placeholderView.textAlignment = self.textAlignment
		placeholderView.frame = rect
		
		updatePlaceholderDisplay()
	}
	
	private func updatePlaceholderDisplay() {
		placeholderView.isHidden = self.text.characters.count > 0 || (self.placeholder?.characters.count ?? 0) == 0
	}
	
	private func placeholderRectForBounds(_ bounds: CGRect) -> CGRect {
		// Inset the rect
		var rect = UIEdgeInsetsInsetRect(bounds, self.contentInset)
		
		if let style = self.typingAttributes[NSParagraphStyleAttributeName] {
			rect.origin.x += style.headIndent
			rect.origin.y += style.firstLineHeadIndent
		}
		
		rect.origin.x += correctionFactor
		rect.size.width -= correctionFactor * 2
		
		return rect
	}
	
	func textChanged(_ not: Notification) {
		let obj = not.object as? MinHeightTextView
		if obj != self {
			return
		}
		
		updatePlaceholder()
	}
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		let intrinsicSize = intrinsicContentSize()
		heightConstraint?.constant = intrinsicSize.height
		
		var topCorrect = (bounds.height - contentSize.height * zoomScale) / 2.0
		topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect
		contentOffset = CGPoint(x: 0, y: -topCorrect)
		
		updatePlaceholder()
	}
	
	override public func intrinsicContentSize() -> CGSize {
		var intrinsicContentSize = self.contentSize;
		
		intrinsicContentSize.width += (textContainerInset.left + textContainerInset.right) / 2
		intrinsicContentSize.height += (textContainerInset.top + textContainerInset.bottom) / 2
		
		return intrinsicContentSize
	}
	
	// MARK: - Editing
	
	override public var isEditable: Bool {
		didSet {
			if isEditable {
				editMode()
			} else {
				displayMode()
			}
		}
	}
	
	private func editMode() {
		backgroundColor = UIColor.white()
		layer.borderWidth = 0.6
		textContainerInset = UIEdgeInsets(top: 3, left: 1, bottom: 3, right: 1)
		
		self.autocorrectionType = self.editCorrectionType
	}
	
	private func displayMode() {
		backgroundColor = nil
		layer.borderWidth = 0
		textContainerInset = UIEdgeInsetsZero
		
		self.autocorrectionType = .no
	}
	
}
