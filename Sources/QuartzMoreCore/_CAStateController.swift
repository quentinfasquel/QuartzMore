//
//  _CAStateController.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 31/08/2025.
//

import Dynamic
import QuartzCore

public struct _CAStateController {
    package let instance: NSObject

    public let layer: CALayer

    public init(layer: CALayer) {
        let stateController = Dynamic.CAStateController(layer: layer).asObject
        guard let stateController else {
            fatalError()
        }
        self.instance = stateController
        self.layer = layer
    }
    
    public func setState(_ state: _CAState, of layer: CALayer) {
        Dynamic(instance).setState(state.instance, ofLayer: layer)
    }
    
    public func setState(_ state: _CAState, of layer: CALayer, transitionSpeed: Float) {
        Dynamic(instance).setState(state.instance, ofLayer: layer, transitionSpeed: transitionSpeed)
    }
}
