//
//  CALayer.swift
//  MBLibrary
//
//  Created by Marco Boschi on 27/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import QuartzCore
import UIKit

extension CALayer {
	
	public func image(transparent: Bool = true) -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(self.frame.size, !transparent, 0)
		
		guard let current = UIGraphicsGetCurrentContext() else {
			return nil
		}
		
		self.render(in: current)
		let res = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		return res
	}
	
}
