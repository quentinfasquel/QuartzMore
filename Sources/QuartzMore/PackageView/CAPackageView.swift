//
//  QuartzMore.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 22/08/2025.
//

import Foundation
import QuartzCore
import QuartzMoreCore
import SwiftUI
import Turbocharger

public struct CAPackageView: CALayerRepresentable {
    let contentsURL: URL
    let type: _CAPackageType
    let options: [String: Any]
    let onLoad: ((Result<_CAStateController, Error>) -> Void)?

    public init(
        contentsOf: URL!,
        type: _CAPackageType,
        options: [String: Any] = [:],
        onLoad: ((Result<_CAStateController, Error>) -> Void)? = nil,
    ) {
        self.contentsURL = contentsOf
        self.type = type
        self.options = options
        self.onLoad = onLoad
    }
    
    public func makeCALayer(_ layer: CALayer, context: Context) {
        guard let rootLayer = context.coordinator.package?.rootLayer else {
            // This represents an error
//            layer.contents = PlatformColor.red.cgColor
            return
        }

        layer.addSublayer(rootLayer)
    }

    public func updateCALayer(_ layer: CALayer, context: Context) {
        guard let package = context.coordinator.package, let rootLayer = package.rootLayer else {
            return
        }

        // TODO
//        layer.frame = UIScreen.main.bounds
        layer.isGeometryFlipped = package.geometryFlipped

        // Scale to fit while preserving aspect
        let scaleX = layer.bounds.width / rootLayer.bounds.width
        let scaleY = layer.bounds.height / rootLayer.bounds.height
        let scale  = min(scaleX, scaleY)
        rootLayer.transform = CATransform3DMakeScale(scale, scale, 1)
        rootLayer.position = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    @MainActor
    public final class Coordinator: Sendable {
        let package: _CAPackage!
        let stateController: _CAStateController!
        
        var isGeometryFlipped: Bool { package.geometryFlipped }

        public init(parent: CAPackageView) {
            do {
                package = try _CAPackage(
                    contentsOf: parent.contentsURL,
                    type: parent.type,
                    options: parent.options
                )

                stateController = _CAStateController(
                    layer: package.rootLayer
                )

                parent.onLoad?(.success(stateController))
            } catch {
                package = nil
                stateController = nil
                
                parent.onLoad?(.failure(error))
            }
        }
    }
}

