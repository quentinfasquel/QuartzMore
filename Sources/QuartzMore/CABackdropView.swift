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


#elseif canImport(AppKit)
import AppKit
//import QuartzCore

final class _CABackdropLayerView: NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
    }

    override func makeBackingLayer() -> CALayer {
        // Use the private CABackdropLayer if present, else fall back
        (NSClassFromString("CABackdropLayer") as? CALayer.Type)?.init() ?? CALayer()
    }

    // Rough equivalent of "isUserInteractionEnabled = false"
    // (prevents the view from intercepting mouse events)
    override func hitTest(_ point: NSPoint) -> NSView? { nil }
}

public struct CABackdropView: NSViewRepresentable {
    public let filters: [_CAFilter]
    public let layer: ((CALayer) -> Void)?

    public init(filters: [_CAFilter] = [], layer: ((CALayer) -> Void)? = nil) {
        self.filters = filters
        self.layer = layer
    }

    @MainActor public final class Coordinator {
        let view = _CABackdropLayerView()

        init(_ parent: CABackdropView) {
            view.layer?.filters = parent.filters
        }
    }

    public func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self)
        if let layer = coordinator.view.layer {
            self.layer?(layer)
        }
        return coordinator
    }

    public func makeNSView(context: Context) -> NSView {
        context.coordinator.view
    }

    public func updateNSView(_ nsView: NSView, context: Context) {
        // If you want filters to update dynamically:
        (nsView as? _CABackdropLayerView)?.layer?.filters = filters
    }
}
#endif

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
