//
//  CAFilterArrayBuilder.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 19/02/2026.
//

import QuartzMoreCore
import SwiftUI

// MARK: - Layer Backed View

@_documentation(visibility: internal)
public protocol _LayerBackedView: View {}

// MARK: Layer Backed View Modifier

extension View {
    func _applyLayerEnvironment(onLayer layer: CALayer?) -> some View {
        modifier(_LayerBackedViewModifier(layer: layer))
    }
}

fileprivate struct _LayerBackedViewModifier: ViewModifier {
    @Environment(\.layerFilters) private var filters
    @Environment(\.layerMeshTransform) private var meshTransform
    @Environment(\.layerMeshTransformCallback) private var meshTransformCallback
    
    let layer: CALayer?

    func body(content: Content) -> some View {
        content
            .onChange(of: layer, initial: true) { _, layer in
                applyFilters()
                applyMeshTransform()
            }
            .onChange(of: filters) { _, filters in
                applyFilters()
            }
            .onChange(of: meshTransform != layer?._meshTransform) { _, _ in
                applyMeshTransform()
            }
            // Consume environment so it doesn't propagate to children
            .environment(\.layerFilters, nil)
            .environment(\.layerMeshTransform, nil)
            .environment(\.layerMeshTransformCallback, nil)
    }
    
    func applyFilters() {
        layer?.filters = filters
    }
    
    func applyMeshTransform() {
        if let layer, layer._meshTransform != meshTransform {
            layer._meshTransform = meshTransform
            if let meshTransform {
                meshTransformCallback?(layer, meshTransform)
            } // else did remove
        }
    }
}

// MARK: - Environment Modifier

private struct _LayerBackedViewEnvironmentModifier<Content: _LayerBackedView>: _LayerBackedView {
    let content: Content
    let configure: (inout EnvironmentValues) -> Void

    init(_ content: Content, configure: @escaping (inout EnvironmentValues) -> Void) {
        self.content = content
        self.configure = configure
    }

    var body: some View {
        content.transformEnvironment(\.self) { env in
            configure(&env)
        }
    }
}

// MARK: - Layer Environment Values

private extension EnvironmentValues {
    @Entry var layerFilters: [_CAFilter]?
    @Entry var layerMeshTransform: _CAMeshTransform?
    @Entry var layerMeshTransformCallback: ((CALayer, _CAMeshTransform) -> Void)?
}

// MARK: - Layer Modifiers

public extension _LayerBackedView {

    // MARK: - Filters Modifiers
    
    func filters(_ filters: [_CAFilter]) -> some _LayerBackedView {
        _LayerBackedViewEnvironmentModifier(self) { environment in
            environment.layerFilters = filters
        }
    }
    
    func filters(@_CAFilterArrayBuilder _ builder: () -> [_CAFilter]) -> some _LayerBackedView {
        filters(builder())
    }
        
    // MARK: - Mesh Transform Modifiers

    func meshTransform(
        width: Int,
        height: Int,
        depthNormalization: CADepthNormalization = .none,
        onUpdate: @escaping (CALayer, _CAMeshTransform) -> Void
    ) -> some _LayerBackedView {
        _LayerBackedViewEnvironmentModifier(self) { environment in
            environment.layerMeshTransformCallback
            environment.layerMeshTransform = _CAMeshTransform(
                width: width,
                height: height,
                depthNormalization: depthNormalization
            )
        }

    }
    
    func mutableMeshTransform(
        width: Int,
        height: Int,
        depthNormalization: CADepthNormalization = .none,
        onUpdate: @escaping (CALayer, _CAMutableMeshTransform) -> Void
    ) -> some _LayerBackedView {
        _LayerBackedViewEnvironmentModifier(self) { environment in
            environment.layerMeshTransformCallback = {
                onUpdate($0, $1 as! _CAMutableMeshTransform)
            }
            environment.layerMeshTransform = _CAMutableMeshTransform(
                width: width,
                height: height,
                depthNormalization: depthNormalization
            )
        }
    }
}
