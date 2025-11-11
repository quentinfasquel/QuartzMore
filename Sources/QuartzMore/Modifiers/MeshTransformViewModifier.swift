//
//  MeshTransformViewModifier.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 11/11/2025.
//

import SwiftUI
@_exported import QuartzMoreCore

fileprivate struct CAMeshTransformViewModifier: ViewModifier {
    var width: Int
    var height: Int
    var depthNormalization: CADepthNormalization = .none
    var onUpdate: (CALayer, _CAMutableMeshTransform) -> Void
    func body(content: Content) -> some View {
        content.overlay(CABackdropView { layer in
            let meshTransform = _CAMutableMeshTransform(
                width: width,
                height: height,
                depthNormalization: depthNormalization
            )
            layer._meshTransform = meshTransform
            onUpdate(layer, meshTransform)
        })
    }
}

public extension View {
    func meshTransform(
        width: Int,
        height: Int,
        depthNormalization: CADepthNormalization = .none,
        onUpdate: @escaping (CALayer, _CAMutableMeshTransform) -> Void
    ) -> some View {
        modifier(
            CAMeshTransformViewModifier(
                width: width,
                height: height,
                depthNormalization: depthNormalization,
                onUpdate: onUpdate
            )
        )
    }
}
