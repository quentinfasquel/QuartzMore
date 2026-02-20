//
//  MeshTransformViewModifier.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 11/11/2025.
//

import SwiftUI
public import QuartzMoreCore

fileprivate struct MeshTransformViewModifier: ViewModifier {
    var width: Int
    var height: Int
    var depthNormalization: CADepthNormalization = .none
    var onUpdate: (CALayer, _CAMutableMeshTransform) -> Void
    func body(content: Content) -> some View {
        content.overlay(
            BackdropView()
                .mutableMeshTransform(
                    width: width,
                    height: height,
                    depthNormalization: depthNormalization,
                    onUpdate: onUpdate
                )
        )
    }
}

fileprivate struct MutableMeshTransformViewModifier: ViewModifier {
    var width: Int
    var height: Int
    var depthNormalization: CADepthNormalization = .none
    var onUpdate: (CALayer, _CAMutableMeshTransform) -> Void
    func body(content: Content) -> some View {
        content.overlay(
            BackdropView()
                .mutableMeshTransform(
                    width: width,
                    height: height,
                    depthNormalization: depthNormalization,
                    onUpdate: onUpdate
                )
        )
    }
}

public extension View {

    func meshTransform(
        width: Int,
        height: Int,
        depthNormalization: CADepthNormalization = .none,
        onUpdate: @escaping (CALayer, _CAMeshTransform) -> Void
    ) -> some View {
        modifier(
            MeshTransformViewModifier(
                width: width,
                height: height,
                depthNormalization: depthNormalization,
                onUpdate: onUpdate
            )
        )
    }
    
    func mutableMeshTransform(
        width: Int,
        height: Int,
        depthNormalization: CADepthNormalization = .none,
        onUpdate: @escaping (CALayer, _CAMutableMeshTransform) -> Void
    ) -> some View {
        modifier(
            MutableMeshTransformViewModifier(
                width: width,
                height: height,
                depthNormalization: depthNormalization,
                onUpdate: onUpdate
            )
        )
    }

}
