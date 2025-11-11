//
//  CAMeshTransform_init.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 27/10/2025.
//

import QuartzMoreCore

extension _CAMeshTransform {

    public convenience init(width: Int, height: Int, depthNormalization: CADepthNormalization = .none) {
        var vertices: [CAMeshVertex] = []
        for vIndex in 0..<height {
            for hIndex in 0..<width {
                // normalized position
                let position = CGPoint(
                    x: CDouble(hIndex) / CDouble(width - 1),
                    y: CDouble(vIndex) / CDouble(height - 1)
                )
                
                let vertex = CAMeshVertex(
                    position: position,
                    point3D: CAPoint3D(x: position.x, y: position.y, z: 0.5)
                )
                vertices.append(vertex)
            }
        }
        
        var faces: [CAMeshFace] = []
        for vIndex in 0..<(height - 1) {
            for hIndex in 0..<(width - 1) {
                
                let topLeft = UInt32(vIndex * width + hIndex)
                let topRight = topLeft + 1
                let bottomLeft = UInt32((vIndex + 1) * width + hIndex)
                let bottomRight = bottomLeft + 1
                
                let face = CAMeshFace(
                    indices: (topLeft, topRight, bottomRight, bottomLeft),
                    weights: (0.0, 0.0, 0.0, 0.0)
                )
                faces.append(face)
            }
        }
  
        self.init(
            vertexCount: vertices.count,
            vertices: vertices,
            faceCount: faces.count,
            faces: faces,
            depthNormalization: depthNormalization
        )
    }
}
