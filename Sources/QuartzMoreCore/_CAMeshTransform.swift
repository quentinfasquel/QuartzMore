//
//  CAMeshTransform.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 07/11/2025.
//

@_exported import CoreGraphics
import Dynamic
import QuartzCore
import QuartzMoreProxy

@frozen
public struct CAPoint3D: Hashable {
    public var x: CDouble
    public var y: CDouble
    public var z: CDouble

    public init(x: Double, y: Double, z: Double) {
        self.x = CDouble(x)
        self.y = CDouble(y)
        self.z = CDouble(z)
    }
}

@frozen
public struct CAMeshVertex: Equatable {
    public var position: CGPoint
    public var point3D: CAPoint3D

    public init(position: CGPoint, point3D: CAPoint3D) {
        self.position = position
        self.point3D = point3D
    }
    
    // Compare using Float precision since CAMeshTransform stores
    // vertices with float precision, not double
    public static func == (lhs: CAMeshVertex, rhs: CAMeshVertex) -> Bool {
        Float(lhs.position.x) == Float(rhs.position.x) &&
        Float(lhs.position.y) == Float(rhs.position.y) &&
        Float(lhs.point3D.x) == Float(rhs.point3D.x) &&
        Float(lhs.point3D.y) == Float(rhs.point3D.y) &&
        Float(lhs.point3D.z) == Float(rhs.point3D.z)
    }
}

@frozen
public struct CAMeshFace: Equatable {
    public var indices: (UInt32, UInt32, UInt32, UInt32)
    public var weights: (Float, Float, Float, Float)

    public init(
        indices: (UInt32, UInt32, UInt32, UInt32),
        weights:  (Float, Float, Float, Float)
    ) {
        self.indices = indices
        self.weights = weights
    }
    
    public static func == (lhs: CAMeshFace, rhs: CAMeshFace) -> Bool {
        lhs.indices == rhs.indices && lhs.weights == rhs.weights
    }
}

@frozen
public enum CADepthNormalization: String {
    case max
    case min
    case none
    case width
    case height
    case average
}

// MARK: -

///
/// https://ciechanow.ski/mesh-transforms/
///
public class _CAMeshTransform: Proxy {

    let dynamicTarget: Dynamic

    class var dynamicClass: Dynamic {
        Dynamic.CAMeshTransform
    }
    
    public var vertexCount: Int {
        value(forKeyPath: "vertexCount") as! Int
    }

    public var faceCount: Int {
        value(forKeyPath: "faceCount") as! Int
    }
    
    public init(
        vertexCount: Int,
        vertices: [CAMeshVertex],
        faceCount: Int,
        faces: [CAMeshFace],
        depthNormalization: CADepthNormalization = .none
    ) {
        let dynamicObject: NSObject? = vertices.withUnsafeBufferPointer { verticesPtr in
            faces.withUnsafeBufferPointer { facesPtr in
                Self.dynamicClass.meshTransformWithVertexCount(
                    CUnsignedLongLong(vertexCount),
                    vertices: verticesPtr,
                    faceCount: CUnsignedLongLong(faceCount),
                    faces: facesPtr,
                    depthNormalization: depthNormalization.rawValue
                )
            }
        }

        dynamicTarget = Dynamic(dynamicObject)
        super.init(target: dynamicObject!)
    }
    
    public func vertex(at vertexIndex: Int) -> CAMeshVertex {
        return dynamicTarget.vertexAtIndex(CUnsignedLongLong(vertexIndex))!
    }

    public func face(at faceIndex: Int) -> CAMeshFace {
        return dynamicTarget.faceAtIndex(CUnsignedLongLong(faceIndex))!
    }
}

// MARK: - CALayer

extension CALayer {
    public var _meshTransform: _CAMeshTransform? {
        get { value(forKey: "meshTransform") as? _CAMeshTransform }
        set { setValue(newValue, forKey: "meshTransform") }
    }
}
