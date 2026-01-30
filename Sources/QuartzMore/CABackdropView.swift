//
//  CABackdropView.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 31/08/2025.
//

import CAFilterBuiltins
import Dynamic
import SwiftUI

#if canImport(UIKit)

final class _CABackdropLayerView: UIView {
    override class var layerClass: AnyClass {
        NSClassFromString("CABackdropLayer") ?? CALayer.self
    }
}

public struct CABackdropView: UIViewRepresentable {

    public let filters: [_CAFilter]
    public let layer: ((CALayer) -> Void)?
    
    public init(filters: [_CAFilter] = [], layer: ((CALayer) -> Void)? = nil) {
        self.filters = filters
        self.layer = layer
    }
    
    @MainActor public final class Coordinator {
        let view = _CABackdropLayerView()
        init(_ parent: CABackdropView) {
            view.isUserInteractionEnabled = false
            view.layer.filters = parent.filters
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self)
        layer?(coordinator.view.layer)
        return coordinator
    }
    
    public func makeUIView(context: Context) -> UIView {
        context.coordinator.view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
    }
}

#Preview {
    var filter: _CAFilter {
        let gaussian = _CAFilter.gaussianBlur()
        gaussian.inputRadius = 20
        return gaussian
    }

    ZStack {
        Circle()
            .fill(.red)
            .overlay(
                CABackdropView(filters: [filter])
                .saturation(0.2)
            )
    }
}

#endif
