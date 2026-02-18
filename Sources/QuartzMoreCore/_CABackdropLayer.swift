//
//  CABackdropLayer.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 18/02/2026.
//

import QuartzCore
import QuartzMoreProxy

public final class _CABackdropLayer: Proxy {
    
    public class var layerClass: CALayer.Type? {
        NSClassFromString("CABackdropLayer") as? CALayer.Type
    }
    
    public convenience init?() {
        guard let instance = Self.layerClass?.init() as? CALayer else { return nil }
        self.init(target: instance)
    }
}
