//
//  PortalSourceUIView.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 16/02/2026.
//

#if canImport(AppKit)
import AppKit
#endif
import SwiftUI
import QuartzMoreCore

// MARK: - UIView

#if canImport(UIKit)
fileprivate class PortalSourceUIView<Content: View>: UIView {
    let sourceID: PortalSource.ID
    let hostingController: UIHostingController<Content>

    override var intrinsicContentSize: CGSize {
        hostingController.view.intrinsicContentSize
    }

    required init(rootView: Content, sourceID: PortalSource.ID) {
        self.sourceID = sourceID
        self.hostingController = UIHostingController(rootView: rootView)
        super.init(frame: .zero)

        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.view.backgroundColor = .clear
        hostingController.view.frame = bounds
        addSubview(hostingController.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil {
            PortalSourceRegistry.shared.add(sourceID: sourceID, layer: hostingController.view.layer)
        } else {
            PortalSourceRegistry.shared.remove(sourceID: sourceID)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }

    func updateContent(_ content: Content) {
        hostingController.rootView = content
    }
}

// MARK: - NSView

#elseif canImport(AppKit)
fileprivate class PortalSourceNSView<Content: View>: NSHostingView<Content> {
    let sourceID: PortalSource.ID

    required init(rootView: Content, sourceID: PortalSource.ID) {
        self.sourceID = sourceID
        super.init(rootView: rootView)
        wantsLayer = true
    }

    @MainActor @preconcurrency required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        if window != nil, let layer {
            PortalSourceRegistry.shared.add(sourceID: sourceID, layer: layer)
        } else {
            PortalSourceRegistry.shared.remove(sourceID: sourceID)
        }
    }
    
    func updateContent(_ content: Content) {
        self.rootView = content
    }
}
#endif

// MARK: - UIViewRepresentable

#if canImport(UIKit)
public struct PortalSourceView<Content: View>: UIViewRepresentable {
    let sourceID: PortalSource.ID
    let content: Content
      
    public init(id: some Hashable, namespace: Namespace.ID, @ViewBuilder content: () -> Content) {
        self.sourceID = .init(viewID: id, namespace: namespace)
        self.content = content()
    }
    
    public func makeUIView(context: Context) -> UIView {
        PortalSourceUIView(rootView: content, sourceID: sourceID)
    }

    public func updateUIView(_ uiView: UIView, context: Context) {
        (uiView as? PortalSourceUIView<Content>)?.updateContent(content)
    }

    public func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
        uiView.intrinsicContentSize
    }
}

// MARK: - NSViewRepresentable

#elseif canImport(AppKit)
public struct PortalSourceView<Content: View>: NSViewRepresentable {
    let sourceID: PortalSource.ID
    let content: Content
      
    public init(id: some Hashable, namespace: Namespace.ID, @ViewBuilder content: () -> Content) {
        self.sourceID = .init(viewID: id, namespace: namespace)
        self.content = content()
    }
    
    public func makeNSView(context: Context) -> NSView {
        PortalSourceNSView(rootView: content, sourceID: sourceID)
    }

    public func updateNSView(_ nsView: NSView, context: Context) {
        (nsView as? PortalSourceNSView<Content>)?.updateContent(content)
    }
    public func sizeThatFits(_ proposal: ProposedViewSize, nsView: NSView, context: Context) -> CGSize? {
        nsView.intrinsicContentSize
    }
}
#endif

// MARK: - View Modifier

public extension View {
    func portalSource(id: some Hashable, in namespace: Namespace.ID) -> some View {
        PortalSourceView(id: id, namespace: namespace, content: { self })
            .id(id)
    }
}
