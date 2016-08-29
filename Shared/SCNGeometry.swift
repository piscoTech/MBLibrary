//
//  SCNGeometry.swift
//  MBLibrary
//
//  Created by Marco Boschi on 15/08/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//  Faces initializer based on @rickster answer @ http://stackoverflow.com/a/24497926/5031210
//

import SceneKit

extension SCNGeometry {
	
	///Create a custom geometry from the specified arrays of faces, each array will become an indipendent `SCNGeometryElement`.
	public convenience init(faces: [Face]...) {
		let allFaces = faces.reduce([]) { $0 + $1 }
		let allVertexCount = allFaces.count * 3
		let rawVertices = allFaces.map { $0.rawData }.reduce([]) { $0 + $1 }
		let floatSize = MemoryLayout<Float>.size
		let int32Size = MemoryLayout<Int32>.size
		
		let data = NSData(bytes: rawVertices, length: allVertexCount * floatSize * 6) as Data
		
		let vertexSource = SCNGeometrySource(data: data,
		                                     semantic: .vertex,
		                                     vectorCount: allVertexCount,
		                                     usesFloatComponents: true,
		                                     componentsPerVector: 3, //Tridimensional space
		                                     bytesPerComponent: floatSize,
		                                     dataOffset: 0, //The position is at the beginning of the vertex
		                                     dataStride: floatSize * 6 //Bytes for each vertex: 3 data for the vertex position, 3 for the normal
		)
		let normalSource = SCNGeometrySource(data: data,
		                                     semantic: .normal,
		                                     vectorCount: allVertexCount,
		                                     usesFloatComponents: true,
		                                     componentsPerVector: 3,
		                                     bytesPerComponent: floatSize,
											 dataOffset: floatSize * 3, //Normal is after the position
											 dataStride: floatSize * 6 //Bytes for each vertex: 3 data for the vertex position, 3 for the normal
		)
		
		var elements: [SCNGeometryElement] = []
		var start: Int32 = 0
		for e in faces {
			let vertexCount = Int32(e.count) * 3
			let indices = Array(start ..< (start + vertexCount))
			let indexData = NSData(bytes: indices, length: Int(vertexCount) * int32Size) as Data
			start += vertexCount
			
			elements.append(SCNGeometryElement(data: indexData, primitiveType: .triangles,  primitiveCount: e.count, bytesPerIndex: int32Size))
		}
		
		self.init(sources: [vertexSource, normalSource], elements: elements)
	}
	
	///Retrieve the geometry with the specified name (if any) from the passed file.
	///
	///To get the geometry of a node with a given name see `SCNNode.load(from:withName:)`.
	public class func load(from file: URL, withName name: String) -> SCNGeometry? {
		let scene: SCNScene
		do {
			scene = try SCNScene(url: file, options: [:])
		} catch _ {
			return nil
		}
		
		func search(node: SCNNode) -> SCNGeometry? {
			if let geomName = node.geometry?.name, geomName == name {
				return node.geometry
			}
			
			for child in node.childNodes {
				if let geom = search(node: child) {
					return geom
				}
			}
			
			return nil
		}
		
		return search(node: scene.rootNode)
	}
	
}
