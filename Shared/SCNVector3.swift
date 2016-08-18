//
//  SCNVector3.swift
//  MBLibrary
//
//  Created by Marco Boschi on 17/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import SceneKit

public func == (l: SCNVector3, r: SCNVector3) -> Bool {
	return SCNVector3EqualToVector3(l, r)
}

public func + (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
	return SCNVector3(l.x + r.x, l.y + r.y, l.z + r.z)
}

public func - (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
	return SCNVector3(l.x - r.x, l.y - r.y, l.z - r.z)
}

prefix operator - {}
public prefix func - (p: SCNVector3) -> SCNVector3 {
	return SCNVector3(-p.x, -p.y, -p.z)
}

extension SCNVector3: Equatable {
	
	public var float3: Float3 {
		return [x, y, z]
	}
	
	public var module: Float {
		return sqrt(x*x + y*y + z*z)
	}
	
	///The translation matrix corresponding to the vector.
	public var translation: SCNMatrix4 {
		return SCNMatrix4MakeTranslation(x, y, z)
	}
	
	public func normalized() -> SCNVector3 {
		let m = module
		guard m != 0 else {
			return SCNVector3(0,0,0)
		}
		
		return SCNVector3(x / m, y / m, z / m)
	}
	
	///Rotate the vector by applying the rotation specified by the passed vector using the first three component to determine the direction of the rotation axis and the fourth as the angle of rotation (in radians).
	///- parameter by: The rotation vector.
	public func rotated(by: SCNVector4) -> SCNVector3 {
		let vect = SCNVector3ToGLKVector3(self)
		let rotate = SCNMatrix4ToGLKMatrix4(by.rotation)
		
		return SCNVector3FromGLKVector3(GLKMatrix4MultiplyVector3(rotate, vect))
	}
	
	public func scale(by f: Float) -> SCNVector3 {
		return SCNVector3(f*x, f*y, f*z)
	}
	
}
