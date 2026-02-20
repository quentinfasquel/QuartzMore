//
//  BackdropView.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 18/02/2026.
//

import QuartzMoreCore
import SwiftUI

public struct BackdropView: View, _LayerBackedView {
    @State private var layer: CALayer?

    public init() {}

    public var body: some View {
        BackdropViewRepresentable { newLayer in
            self.layer = newLayer
        }
        ._applyLayerEnvironment(onLayer: layer)
    }
}

#if canImport(UIKit)
fileprivate struct BackdropViewRepresentable: UIViewRepresentable {
    public let layer: ((CALayer) -> Void)?

    public func makeUIView(context: Context) -> UIView {
        let uiView = _CABackdropLayerUIView()
        DispatchQueue.main.async {
            layer?(uiView.layer)
        }
        return uiView
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
    }
}
#elseif canImport(AppKit)
fileprivate struct BackdropViewRepresentable: NSViewRepresentable {
    public let layer: ((CALayer) -> Void)?

    public func makeNSView(context: Context) -> NSView {
        let nsView = _CABackdropLayerNSView()
        if let layer = nsView.layer {
            DispatchQueue.main.async {
                self.layer?(layer)
            }
        }
        return nsView
    }

    public func updateNSView(_ nsView: NSView, context: Context) {
    }
}
#endif

// MARK: - Preview

#Preview {
    @Previewable @State var inputRadius: CGFloat = 0
    ZStack(alignment: .topLeading) {
        Circle()
            .fill(.blue)
            .frame(width: 200, height: 200)

        BackdropView()
            .filters {
                let gaussianBlur = _CAFilter.gaussianBlur()
                gaussianBlur.inputRadius = inputRadius
                return [gaussianBlur]
            }
            .frame(width: 100, height: 100)
            .overlay(Rectangle().stroke(lineWidth: 1))
            .offset(x: -10, y: -10)
        
        Circle()
            .fill(.green)
            .frame(width: 200, height: 200)
            .opacity(0.8)
    }
    .safeAreaInset(edge: .bottom) {
        Slider(value: $inputRadius, in: 0...100)
    }
}

