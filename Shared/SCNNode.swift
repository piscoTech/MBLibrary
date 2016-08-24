//
//  SCNNode.swift
//  MBLibrary
//
//  Created by Marco Boschi on 23/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import SceneKit

extension SCNNode {
	
	///Retrieve the node with the specified name (if any) from the passed file.
	public class func load(from file: URL, withName name: String) -> SCNNode? {
		let scene: SCNScene
		do {
			scene = try SCNScene(url: file, options: nil)
		} catch _ {
			return nil
		}
		
		if let n = scene.rootNode.name, n == name {
			return scene.rootNode
		} else {
			return scene.rootNode.childNode(withName: name, recursively: true)
		}
	}
	
}
