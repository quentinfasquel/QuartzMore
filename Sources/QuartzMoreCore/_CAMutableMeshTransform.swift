//
//  CAMutableMeshTransform.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 08/11/2025.
//

import Dynamic
import QuartzCore
import QuartzMoreProxy

public final class _CAMutableMeshTransform: _CAMeshTransform {
    override class var dynamicClass: Dynamic {
        Dynamic.CAMutableMeshTransform
    }

    public func addFace(_ face: CAMeshFace) {
        dynamicTarget.addFace(face)
    }

    public func removeFace(at faceIndex:Int) {
        dynamicTarget.removeFaceAtIndex(CUnsignedLongLong(faceIndex))
    }

    public func replaceFace(at faceIndex: Int, with face: CAMeshFace) {
        let cls: AnyClass? = NSClassFromString("CAMutableMeshTransform")
        let selector = Selector(("replaceFaceAtIndex:withFace:"))
        guard let method = class_getInstanceMethod(cls, selector) else {
            return assertionFailure()
        }

        let implementation = method_getImplementation(method)
        typealias MethodSignature = @convention(c) (AnyObject, Selector, Int, UnsafeRawPointer?) -> Void
        let function = unsafeBitCast(implementation, to: MethodSignature.self)
        withUnsafePointer(to: face) { facePtr in
            function(target, selector, faceIndex, facePtr)
        }
    }

    public func addVertex(_ vertex: CAMeshVertex) {
        dynamicTarget.addVertex(vertex)
    }
    
    public func removeVertex(at vertexIndex: Int) {
        dynamicTarget.removeVertexAtIndex(CUnsignedLongLong(vertexIndex))
    }

    public func replaceVertex(at vertexIndex: Int, with vertex: CAMeshVertex) {
        let cls: AnyClass? = NSClassFromString("CAMutableMeshTransform")
        let selector = Selector(("replaceVertexAtIndex:withVertex:"))
        guard let method = class_getInstanceMethod(cls, selector) else {
            return assertionFailure()
        }
            
        let implementation = method_getImplementation(method)
        typealias MethodSignature = @convention(c) (AnyObject, Selector, Int, UnsafeRawPointer?) -> Void
        let function = unsafeBitCast(implementation, to: MethodSignature.self)
        withUnsafePointer(to: vertex) { vertexPtr in
            function(target, selector, vertexIndex, vertexPtr)
        }
    }
}
