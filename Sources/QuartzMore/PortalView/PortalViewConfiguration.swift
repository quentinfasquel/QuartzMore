//
//  PortalViewConfiguration.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 16/02/2026.
//

import QuartzMoreCore

public struct PortalViewConfiguration: Sendable, Equatable {
    // public var allowedInContextTransform
    // public var allowsBackdropGroups
    public var hidesSourceLayer: Bool
    public var hidesSourceLayerInOtherPortals: Bool
    // public var excludeSeparated: Bool
    public var matchesOpacity: Bool
    public var matchesPosition: Bool
    public var matchesSize: Bool
    public var matchesTransform: Bool
    public var sourceLayerOpacityScale: CGFloat
    
    public static let `default` = PortalViewConfiguration()

    public init(
        hidesSourceLayer: Bool = false,
        hidesSourceLayerInOtherPortals: Bool = false,
        matchesOpacity: Bool = false,
        matchesPosition: Bool = false,
        matchesSize: Bool = true,
        matchesTransform: Bool = false,
        sourceLayerOpacityScale: CGFloat = 1
    ) {
        self.hidesSourceLayer = hidesSourceLayer
        self.hidesSourceLayerInOtherPortals = hidesSourceLayerInOtherPortals
        self.matchesOpacity = matchesOpacity
        self.matchesPosition = matchesPosition
        self.matchesSize = matchesSize
        self.matchesTransform = matchesTransform
        self.sourceLayerOpacityScale = sourceLayerOpacityScale
    }
}

extension _CAPortalLayer {
    func apply(configuration: PortalViewConfiguration) {
//        self.allowedInContextTransform = configuration.allowedInContextTransform
//        self.allowsBackdropGroups = configuration.alllowsBackdropGroups
        self.hidesSourceLayer = configuration.hidesSourceLayer
        self.hidesSourceLayerInOtherPortals = configuration.hidesSourceLayerInOtherPortals
//        self.excludeSeparated = configuration.excludedSeparated
        self.matchesOpacity = configuration.matchesOpacity
        self.matchesPosition = configuration.matchesPosition
//        self.matchesTransform = configuration.matchesTransform
        self.sourceLayerOpacityScale = Float(configuration.sourceLayerOpacityScale)
    }
}
