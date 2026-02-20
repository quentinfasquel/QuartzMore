//
//  PortalSource.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 16/02/2026.
//

import SwiftUI

public struct PortalSource {
    public struct ID: Hashable {
        let viewID: AnyHashable
        let namespace: Namespace.ID
        
        init(viewID: some Hashable, namespace: Namespace.ID) {
            self.viewID = AnyHashable(viewID)
            self.namespace = namespace
        }
    }
    
    private init() {}
}

@Observable
@MainActor
final class PortalSourceRegistry {
    static let shared = PortalSourceRegistry()

    private(set) var storage: [PortalSource.ID: CALayerBox] = [:]

    final class CALayerBox {
        weak var layer: CALayer?
        init(_ layer: CALayer?) { self.layer = layer }
    }

    func add(sourceID: PortalSource.ID, layer: CALayer) {
        storage[sourceID] = CALayerBox(layer)
        cleanup()
    }

    func remove(sourceID: PortalSource.ID) {
        storage[sourceID] = nil
    }

    func cleanup() {
        storage = storage.filter { $0.value.layer != nil }
    }
}
