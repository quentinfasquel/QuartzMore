//
//  CAPortalLayer.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 15/02/2026.
//

import Dynamic
import QuartzCore
import QuartzMoreMacros
import QuartzMoreProxy

public final class _CAPortalLayer: Proxy {

    public convenience init?() {
        let layerClass = NSClassFromString("CAPortalLayer") as? NSObject.Type
        guard let instance = layerClass?.init() as? NSObject else { return nil }
        self.init(target: instance)
    }
    
    @DynamicLookup public var allowedInContextTransform: Bool
    @DynamicLookup public var allowsBackdropGroups: Bool
    @DynamicLookup public var crossDisplay: Bool
    @DynamicLookup public var excludeSeparated: Bool
    @DynamicLookup public var hidesSourceLayer: Bool
    @DynamicLookup public var hidesSourceLayerInOtherPortals: Bool
    @DynamicLookup public var matchesOpacity: Bool
    @DynamicLookup public var matchesPosition: Bool
    @DynamicLookup public var matchesTransform: Bool
    @DynamicLookup public var overrides: NSDictionary?
    @DynamicLookup public var sourceContextId: Int
    @DynamicLookup public var sourceLayer: CALayer?
    @DynamicLookup public var sourceLayerOpacityScale: Float
    @DynamicLookup public var sourceLayerRenderId: Int
}
