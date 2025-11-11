//
//  CAMeshTransformTests.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 07/11/2025.
//

@testable import QuartzMore
@preconcurrency import Dynamic
import Testing

@Suite
struct CAMeshTransformTests {

    let vertices: [CAMeshVertex]
    let faces: [CAMeshFace]

    // Instantiating mock data for a 4x4 vertices grid
    init() {
        vertices = (0..<4).map(Double.init).flatMap { i in
            let y = i / 3.0
            return [
                CAMeshVertex(position: .init(x: 0.0 / 3.0, y: y), point3D: .init(x: 0.0 / 3.0, y: y, z: 0.5)),
                CAMeshVertex(position: .init(x: 1.0 / 3.0, y: y), point3D: .init(x: 1.0 / 3.0, y: y, z: 0.5)),
                CAMeshVertex(position: .init(x: 2.0 / 3.0, y: y), point3D: .init(x: 2.0 / 3.0, y: y, z: 0.5)),
                CAMeshVertex(position: .init(x: 3.0 / 3.0, y: y), point3D: .init(x: 3.0 / 3.0, y: y, z: 0.5)),
            ]
        }

        faces = (0..<3).flatMap { v in
            return (0..<3).map { h in
                let a = UInt32((v + 0) * 4 + h + 0)
                let b = UInt32((v + 0) * 4 + h + 1)
                let d = UInt32((v + 1) * 4 + h + 1)
                let c = UInt32((v + 1) * 4 + h + 0)
                return CAMeshFace(indices: (a, b, d, c), weights: (0, 0, 0, 0))
            }
        }

//        Dynamic.loggingEnabled = true
    }
    
    @Test
    func meshTransform() {
        let meshTransform = _CAMeshTransform(width: 4, height: 4)
        #expect(meshTransform.vertexCount == 16)
        #expect(meshTransform.faceCount == 9)
        for vertexIndex in 0..<16 {
            #expect(meshTransform.vertex(at: vertexIndex) == vertices[vertexIndex])
        }
        for faceIndex in 0..<9 {
            #expect(meshTransform.face(at: faceIndex) == faces[faceIndex])
        }
    }

    @Test
    func mutableMeshTransform() {
        let meshTransform = _CAMutableMeshTransform(width: 4, height: 4)

        #expect(meshTransform.vertexCount == 16)
        #expect(meshTransform.faceCount == 9)
        for vertexIndex in 0..<16 {
            #expect(meshTransform.vertex(at: vertexIndex) == vertices[vertexIndex])
        }
        for faceIndex in 0..<9 {
            #expect(meshTransform.face(at: faceIndex) == faces[faceIndex])
        }
    }
    
    @Test("Removing vertex from a mutable Mesh Transform")
    func mutableMeshTransformRemoveVertex() {
        let meshTransform = _CAMutableMeshTransform(width: 4, height: 4)
        #expect(meshTransform.vertexCount == 16)
        meshTransform.removeVertex(at: 0)
        #expect(meshTransform.vertexCount == 15)
    }
    
    @Test("Adding vertex to a mutable Mesh Transform")
    func mutableMeshTransformAddVertex() {
        let meshTransform = _CAMutableMeshTransform(width: 4, height: 4)
        #expect(meshTransform.vertexCount == 16)
        let newVertex = CAMeshVertex(position: .init(x: 1, y: 1), point3D: .init(x: 1, y: 1, z: 0.5))
        meshTransform.addVertex(newVertex)
        #expect(meshTransform.vertexCount == 17)
    }
    
    @Test("Updating vertex of a mutable Mesh Transform")
    func mutableMeshTransformReplaceVertex() {
        let meshTransform = _CAMutableMeshTransform(width: 4, height: 4)

        var updatedVertex = meshTransform.vertex(at: 5)
        updatedVertex.point3D.x += 0.1
        updatedVertex.point3D.y += 0.1
        
        meshTransform.replaceVertex(at: 5, with: updatedVertex)
        #expect(meshTransform.vertex(at: 5) == updatedVertex)
    }
    
    @Test("Updating face of a mutable Mesh Transform")
    func mutableMeshTransformReplaceFace() {
        let meshTransform = _CAMutableMeshTransform(width: 4, height: 4)

        var updatedFace = meshTransform.face(at: 0)
        updatedFace.weights = (0.5, 0.5, 0.5, 0.5)
        
        meshTransform.replaceFace(at: 0, with: updatedFace)
        #expect(meshTransform.face(at: 0) == updatedFace)
    }
}
