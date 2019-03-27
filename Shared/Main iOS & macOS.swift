//
//  Main iOS & macOS.swift
//  MBLibrary
//
//  Created by Marco Boschi on 20/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import Foundation
import QuartzCore

public let shakingAnimation: CAKeyframeAnimation = {
	let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
	
	animation.timingFunction = CAMediaTimingFunction(name: .linear)
	
	animation.duration = 0.4
	
	animation.values = [-10, 10, -10, 10, -5, 5, -2.5, 2.5, 0]
	return animation
}()
