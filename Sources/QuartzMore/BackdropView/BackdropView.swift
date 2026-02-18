//
//  BackdropView.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 18/02/2026.
//

import SwiftUI

#if canImport(UIKit)
public struct BackdropView: UIViewRepresentable {
    public let layer: ((CALayer) -> Void)?

    public func makeUIView(context: Context) -> UIView {
        let uiView = _CABackdropLayerUIView()
        layer?(uiView.layer)
        return uiView
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
#elseif canImport(AppKit)
public struct BackdropView: NSViewRepresentable {
    public let layer: ((CALayer) -> Void)?

    public func makeNSView(context: Context) -> NSView {
        let nsView = _CAPortalLayerNSView()
        if let layer = nsView.layer {
            self.layer?(layer)
        }
        return nsView
    }

    public func updateNSView(_ nsView: NSView, context: Context) {
    }
}
#endif

import CAFilterBuiltins

#Preview {
    ZStack(alignment: .topLeading) {
        Circle()
            .fill(.green)
            .frame(width: 200, height: 200)

        BackdropView { layer in
            let gaussianBlur = _CAFilter.gaussianBlur()
            gaussianBlur.inputRadius = 10
            layer.filters = [gaussianBlur]
        }
        .frame(width: 100, height: 100)
        .overlay(Rectangle().stroke(lineWidth: 1))
        .offset(x: -10, y: -10)
    }
}
