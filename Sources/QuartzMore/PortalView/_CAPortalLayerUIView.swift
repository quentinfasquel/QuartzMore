//
//  var.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 18/02/2026.
//

import QuartzMoreCore
import SwiftUI

// MARK: - UIView

#if canImport(UIKit)

/// A UIView-backed host for `_CAPortalLayer`.
///
/// This view installs the appropriate Core Animation layer class and manages
/// intrinsic content size based on the source layer's bounds. It acts as a
/// lightweight container that forwards configuration to its backing
/// `_CAPortalLayer`.
///
/// - Note: This type is likely similar in responsibilities to UIKit's private
///   `_UIPortalView`.
final class _CAPortalLayerUIView: UIView {
    lazy var portalLayer = _CAPortalLayer(target: layer)

    var sourceBounds: CGRect? {
        didSet { invalidateIntrinsicContentSize() }
    }

    override class var layerClass: AnyClass {
        _CAPortalLayer.layerClass ?? CALayer.self
    }

    override var intrinsicContentSize: CGSize {
        sourceBounds?.size ?? super.intrinsicContentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
    func setSourceLayer(_ sourceLayer: CALayer, configuration: PortalViewConfiguration) {
        portalLayer.sourceLayer = sourceLayer
        portalLayer.apply(configuration: configuration)
        sourceBounds = configuration.matchesSize ? sourceLayer.bounds : nil
    }

    func resetSourceLayer() {
        portalLayer.sourceLayer = nil
    }
}

// MARK: - NSView

#elseif canImport(AppKit)
import AppKit

/// An NSView-backed host for `_CAPortalLayer`.
///
/// This view opts into layer-backing, installs the appropriate Core Animation
/// layer class for its backing layer, and manages intrinsic content size based
/// on the source layer's bounds. It forwards configuration to its backing
/// `_CAPortalLayer`.
///
/// - Note: This type is likely similar in responsibilities to AppKit's private
///   `_NSPortalLayerBackedView`.
final class _CAPortalLayerNSView: NSView {
    lazy var portalLayer = _CAPortalLayer(target: layer)

    var sourceBounds: CGRect? {
        didSet { invalidateIntrinsicContentSize() }
    }

    override var intrinsicContentSize: CGSize {
        sourceBounds?.size ?? super.intrinsicContentSize
    }
        
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
    }

    override func makeBackingLayer() -> CALayer {
        _CAPortalLayer.layerClass?.init() ?? CALayer()
    }

    override func layout() {
        super.layout()
        invalidateIntrinsicContentSize()

        if let sourceBounds {
            let center = CGPoint(x: sourceBounds.midX, y: sourceBounds.midY)
            frame = sourceBounds.offsetBy(dx: center.x, dy: center.y)
            clipsToBounds = false
        }
    }

    func setSourceLayer(_ sourceLayer: CALayer, configuration: PortalViewConfiguration) {
        portalLayer.sourceLayer = sourceLayer
        portalLayer.apply(configuration: configuration)
        sourceBounds = configuration.matchesSize ? sourceLayer.bounds : nil
    }
    
    func resetSourceLayer() {
        portalLayer.sourceLayer = nil
    }
}
#endif


