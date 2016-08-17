//
//  SCNVector3.swift
//  MBLibrary
//
//  Created by Marco Boschi on 17/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import SceneKit

public func == (l: SCNVector3, r: SCNVector3) -> Bool {
	return l.x == r.x && l.y == r.y && l.z == r.z
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
	
	public func module() -> Float {
		return sqrt(x*x + y*y + z*z)
	}
	
	public func normalized() -> SCNVector3 {
		let module = self.module()
		guard module != 0 else {
			return SCNVector3(0,0,0)
		}
		
		return SCNVector3(x / module, y / module, z / module)
	}
	
}
