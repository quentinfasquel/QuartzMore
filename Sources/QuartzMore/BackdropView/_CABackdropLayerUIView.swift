//
//  _CABackdropLayerUIView.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 18/02/2026.
//

import QuartzMoreCore
import SwiftUI

#if canImport(UIKit)

final class _CABackdropLayerUIView: UIView {
    override class var layerClass: AnyClass {
        _CABackdropLayer.layerClass ?? CALayer.self
    }
}

#elseif canImport(AppKit)
import AppKit

final class _CABackdropLayerNSView: NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
    }

    override func makeBackingLayer() -> CALayer {
        _CABackdropLayer.layerClass?.init() ?? CALayer()
    }
}
#endif
