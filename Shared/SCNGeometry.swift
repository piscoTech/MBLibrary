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
	
	public convenience init(faces: [Face]) {
		let vertexCount = faces.count * 3
		let rawVertices = faces.map { $0.rawData }.reduce([]) { $0 + $1 }
		let dataType = Float.self
		
		let data = NSData(bytes: rawVertices, length: vertexCount * sizeof(dataType) * 6) as Data
		
		let vertexSource = SCNGeometrySource(data: data,
		                                     semantic: SCNGeometrySourceSemanticVertex,
		                                     vectorCount: vertexCount,
		                                     floatComponents: true,
		                                     componentsPerVector: 3, //Tridimensional space
		                                     bytesPerComponent: sizeof(dataType),
		                                     dataOffset: 0, //The position is at the beginning of the vertex
		                                     dataStride: sizeof(dataType) * 6 //Bytes for each vertex: 3 data for the vertex position, 3 for the normal
		)
		let normalSource = SCNGeometrySource(data: data,
		                                     semantic: SCNGeometrySourceSemanticNormal,
		                                     vectorCount: vertexCount,
		                                     floatComponents: true,
		                                     componentsPerVector: 3,
		                                     bytesPerComponent: sizeof(dataType),
											dataOffset: sizeof(dataType) * 3, //Normal is after the position
											dataStride: sizeof(dataType) * 6 //Bytes for each vertex: 3 data for the vertex position, 3 for the normal
		)
		
		//Use a Swift Range to quickly construct a sequential index buffer
		let indexData = NSData(bytes: Array<Int32>(0 ..< Int32(vertexCount)),
		                       length: vertexCount * sizeof(Int32.self)) as Data
		
		let element = SCNGeometryElement(data: indexData,
		                                 primitiveType: .triangles,
		                                 primitiveCount: faces.count,
		                                 bytesPerIndex: sizeof(Int32.self))
		
		self.init(sources: [vertexSource, normalSource], elements: [element])
	}
	
}
