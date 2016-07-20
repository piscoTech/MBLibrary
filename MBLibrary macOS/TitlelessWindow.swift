//
//  TitlelessWindow.swift
//  MBLibrary
//
//  Created by Marco Boschi on 30/09/15.
//  Copyright © 2015 Marco Boschi. All rights reserved.
//

import Cocoa

public class TitlelessWindow: NSWindow {

	override public func awakeFromNib() {
		super.awakeFromNib()
		
		self.titleVisibility = NSWindowTitleVisibility.hidden
		self.titlebarAppearsTransparent = true
		self.styleMask.update(with: .fullSizeContentView)
		
		self.collectionBehavior = .fullScreenAuxiliary
	}

}
