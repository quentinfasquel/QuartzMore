//
//  ContentView.swift
//  ExampleQuartzMore
//
//  Created by Quentin Fasquel on 04/09/2025.
//

import SwiftUI
import CAFilterBuiltins

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Quartz More") {
                    // TODO: BackdropView example

                    NavigationLink("Portal view") {
                        PortalViewExample()
                    }

                    NavigationLink("Package view (CAPackage)") {
                        ShockwaveEffectExample()
                    }
                    
                    // Mesh Interpolator / Mutable Mesh
                    NavigationLink("Mesh transform") {
                        MeshTransformExample()
                    }

                    DisclosureGroup("CALayer Views") {

                        NavigationLink("_CAChameleonLayerView") {}
                            .disabled(true)

                        NavigationLink("_CAEmitterLayerView") {}
                            .disabled(true)

                        NavigationLink("_CAFlipBookLayerView") {}
                            .disabled(true)

                        NavigationLink("_CAGainMapLayerView") {}
                            .disabled(true)
                        
                        // Gradient Layer (custom ColorSpace?)
                        NavigationLink("_CAGradientLayerView") {}
                            .disabled(true)
                        
                        // Linear Mask Layer
                        NavigationLink("_CALinearMaskLayerView") {}
                            .disabled(true)

                        NavigationLink("_CAPortalLayerView") {}
                            .disabled(true)

                        // Tiled Layer
                        NavigationLink("_CATiledLayerView") {}
                            .disabled(true)

                        // Shape, Replicator, Text, etc.
                    }
                }
                
                Section("Core Animation Filters") {
                    NavigationLink("All Filters") {
                        FilterExamplePicker()
                    }

                    DisclosureGroup("\(CAFilterType.allCases.count) filters") {
                        ForEach(CAFilterType.allCases) { filterType in
                            NavigationLink(filterType.displayTitle) {
                                filterType.makeExample()
                            }
                            .disabled(filterType.isDisabled)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
