//
//  MinHeightTextField.swift
//  WorkTime
//
//  Created by Marco Boschi on 22/06/15.
//  Copyright (c) 2015 Marco Boschi. All rights reserved.
//

import Cocoa

public class MinHeightTextField: NSTextField {
	
	private var isEditing = false

	override public var intrinsicContentSize: NSSize {
		get {
			if !(self.cell! as! NSTextFieldCell).wraps {
				return super.intrinsicContentSize
			}
			
			var intrinsicSize = super.intrinsicContentSize
			
			// If we're being edited, get the shared NSTextView field editor, so we can get more info
			if isEditing {
				let fieldEditor = window!.fieldEditor(false, for: self) as! NSTextView
				let usedRect = fieldEditor.textContainer!.layoutManager!.usedRect(for: fieldEditor.textContainer!)
				
				intrinsicSize.height = usedRect.size.height + 5
			} else {
				var frame = self.frame
				let width = frame.size.width
	
				// Make the frame very high, while keeping the width
				frame.size.height = CGFloat.greatestFiniteMagnitude;
	
				// Calculate new height within the frame
				// with practically infinite height.
				let height = (self.cell! as! NSTextFieldCell).cellSize(forBounds: frame).height
	
				intrinsicSize = NSSize(width: width, height: height)
			}
			
			return intrinsicSize
		}
	}
	
	// you need to invalidate the layout on text change, else it wouldn't grow by changing the text
	override public func textDidChange(_ notification: Notification) {
		super.textDidChange(notification)
		invalidateIntrinsicContentSize()
	}
	
	override public func textDidBeginEditing(_ notification: Notification) {
		super.textDidBeginEditing(notification)
		
		isEditing = true
	}
	
	override public func textDidEndEditing(_ notification: Notification) {
		super.textDidEndEditing(notification)
		
		isEditing = false
	}
	
}
