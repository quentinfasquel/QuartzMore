//
//  CAPortalView.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 15/02/2026.
//

import SwiftUI

// MARK: - UIViewRepresentable

#if canImport(UIKit)

/// A SwiftUI bridge that renders a portal to an existing CALayer source.
///
/// PortalView displays the contents of a source layer (registered via
/// `portalSource(id:in:)`) inside a SwiftUI hierarchy.
/// It bridges the private `CAPortal​Layer` via a `UIView​Representable`, using `_​CAPortal​Layer​UIView` — a custom `UIView` whose backing layer is `CAPortal​Layer`.
///
/// - Note: Alternatives include using UIKit's private `_​UIPortal​View` in place of `_​CAPortal​Layer​UIView`, or bridging `CAPortal​Layer` directly into SwiftUI via the private `_​CALayer​View`.
public struct PortalView: UIViewRepresentable {
    var source: PortalSourceRegistry.CALayerBox
    var sourceID: PortalSource.ID
    var configuration: PortalViewConfiguration

    public init(sourceID viewID: some Hashable, namespace: Namespace.ID, configuration: PortalViewConfiguration = .default) {
        self.sourceID = PortalSource.ID(viewID: viewID, namespace: namespace)
        self.source = PortalSourceRegistry.shared.storage[sourceID, default: .init(nil)]
        self.configuration = configuration
    }
    
    public func makeUIView(context: Context) -> UIView {
        let uiView = _CAPortalLayerUIView()
        uiView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        uiView.layer.frame = uiView.bounds
        return uiView
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        if let sourceLayer = source.layer {
            (uiView as? _CAPortalLayerUIView)?.setSourceLayer(sourceLayer, configuration: configuration)
        }
    }
    
    public static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        (uiView as? _CAPortalLayerUIView)?.resetSourceLayer()
    }
    
    public func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
        uiView.intrinsicContentSize
    }
}

// MARK: - NSViewRepresentable

#elseif canImport(AppKit)
import AppKit

/// A SwiftUI bridge that renders a portal to an existing CALayer source.
///
/// PortalView displays the contents of a source layer (registered via
/// `portalSource(id:in:)`) inside a SwiftUI hierarchy.
/// It bridges the private `CAPortal​Layer` via a `NSView​Representable`, using `_​CAPortal​Layer​NSView` — a custom `NSView` whose backing layer is `CAPortal​Layer`.
///
/// - Note: Alternatives include using AppKit's private `_​NSPortalLayerBacked​View` in place of `_​CAPortal​Layer​NSView`, or bridging `CAPortal​Layer` directly into SwiftUI via the private `_​CALayer​View`.
public struct PortalView: NSViewRepresentable {
    var source: PortalSourceRegistry.CALayerBox
    var sourceID: PortalSource.ID
    var configuration: PortalViewConfiguration

    public init(sourceID viewID: some Hashable, namespace: Namespace.ID, configuration: PortalViewConfiguration = .default) {
        self.sourceID = .init(viewID: viewID, namespace: namespace)
        self.source = PortalSourceRegistry.shared.storage[sourceID, default: .init(nil)]
        self.configuration = configuration
    }

    public func makeNSView(context: Context) -> NSView {
        let nsView = _CAPortalLayerNSView()
        nsView.autoresizingMask = [.width, .height]
        return nsView
    }

    public func updateNSView(_ nsView: NSView, context: Context) {
        if let sourceLayer = source.layer {
            (nsView as? _CAPortalLayerNSView)?.setSourceLayer(sourceLayer, configuration: configuration)
        }
    }

    public static func dismantleNSView(_ nsView: NSView, coordinator: ()) {
        (nsView as? _CAPortalLayerNSView)?.resetSourceLayer()
    }

    public func sizeThatFits(_ proposal: ProposedViewSize, nsView: NSView, context: Context) -> CGSize? {
        nsView.intrinsicContentSize
    }
}
#endif

#Preview {
    @Previewable @Namespace var namespace

    let content = Image(systemName: "sun.horizon.fill")
        .font(.largeTitle)
        .scaleEffect(2)
        .symbolRenderingMode(.multicolor)
        .symbolEffect(.breathe, isActive: true)
        .frame(width: 100, height: 100)
        .padding()
        .background(.black.gradient, in: .rect(topLeadingRadius: 12, topTrailingRadius: 12))

    
    VStack(spacing: 0) {
        content
            .portalSource(id: "source", in: namespace)
            .overlay(alignment: .bottom) {
                Text("Source View")
                    .padding(.bottom, 8)
            }
        
        PortalView(
            sourceID: "source",
            namespace: namespace,
            configuration: .init(
                hidesSourceLayer: true,
                hidesSourceLayerInOtherPortals: true,
                matchesOpacity: false,
                matchesPosition: false,
//                matchesSize: false,
                matchesTransform: false,
                sourceLayerOpacityScale: 1
            )
        )
            .scaleEffect(y: -1)
            .mask(LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom))
            .opacity(0.5)
            .overlay(alignment: .top) {
                Text("Portal View")
                    .padding(.top, 8)
            }
        PortalView(
            sourceID: "source",
            namespace: namespace,
            configuration: .init(
//                hidesSourceLayer: false,
//                hidesSourceLayerInOtherPortals: true,
                matchesOpacity: false,
                matchesPosition: false,
//                matchesSize: false,
                matchesTransform: false,
                sourceLayerOpacityScale: 1
            )
        )

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .foregroundStyle(.white)
    .background(.secondary)
}


