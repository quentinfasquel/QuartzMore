//
//  CAPortalLayerTests.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 15/02/2026.
//

@testable import QuartzMore
import Testing

@Suite
struct CAPortalLayerTests {
    
    @Test
    func initLayer() {
        let portalLayer = _CAPortalLayer()
        
        #expect(portalLayer.allowedInContextTransform == false)
        portalLayer.allowedInContextTransform = true
        #expect(portalLayer.allowedInContextTransform == true)

        #expect(portalLayer.allowsBackdropGroups == false)
        portalLayer.allowsBackdropGroups = true
        #expect(portalLayer.allowedInContextTransform == true)

        #expect(portalLayer.crossDisplay == false)
        portalLayer.crossDisplay = true
        #expect(portalLayer.crossDisplay == true)

        #expect(portalLayer.excludeSeparated == false)
        portalLayer.excludeSeparated = true
        #expect(portalLayer.excludeSeparated == true)

        #expect(portalLayer.hidesSourceLayer == false)
        portalLayer.hidesSourceLayer = true
        #expect(portalLayer.hidesSourceLayer == true)

        #expect(portalLayer.hidesSourceLayerInOtherPortals == false)
        portalLayer.hidesSourceLayerInOtherPortals = true
        #expect(portalLayer.hidesSourceLayerInOtherPortals == true)

        #expect(portalLayer.matchesOpacity == false)
        portalLayer.matchesOpacity = true
        #expect(portalLayer.matchesOpacity == true)

        #expect(portalLayer.matchesPosition == false)
        portalLayer.matchesPosition = true
        #expect(portalLayer.matchesPosition == true)

        #expect(portalLayer.matchesTransform == false)
        portalLayer.matchesTransform = true
        #expect(portalLayer.matchesTransform == true)

        #expect(portalLayer.overrides == nil)

        #expect(portalLayer.sourceContextId == 0)

        #expect(portalLayer.sourceLayer == nil)

        #expect(portalLayer.sourceLayerOpacityScale == 1)

        #expect(portalLayer.sourceLayerRenderId == 0)
    }
}
