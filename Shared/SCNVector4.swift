//
//  SCNVector4.swift
//  MBLibrary
//
//  Created by Marco Boschi on 18/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import SceneKit

extension SCNVector4 {
	
	public static let zero = SCNVector4(0, 0, 0, 0)
	
	///The rotation matrix corresponding to the vector using the first three component to determine the direction of the rotation axis and the fourth as the angle of rotation (in radians).
	public var rotation: SCNMatrix4 {
		return SCNMatrix4MakeRotation(w, x, y, z)
	}
	
}
