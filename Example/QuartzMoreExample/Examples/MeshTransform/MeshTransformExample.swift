//
//  MeshTransformExample.swift
//  QuartzMoreExample
//
//  Created by Quentin Fasquel on 18/10/2025.
//

import QuartzMore
import SwiftUI

struct MeshTransformExample: View {
    @State private var animator = WaterMeshTransformAnimator()
    @State private var showBackdrop: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DefaultContent()
                .ignoresSafeArea()
            
            BackdropView()
                .mutableMeshTransform(width: 4, height: 4) { layer, meshTransform in
                    animator.startAnimation(on: layer, with: meshTransform)
                }
                .filters {
                    let gaussianBlur = _CAFilter.gaussianBlur()
                    gaussianBlur.inputRadius = showBackdrop ? 20 : 0
                    gaussianBlur.inputNormalizeEdges = true
                    return [gaussianBlur]
                }
                .onDisappear {
                    animator.stopAnimation()
                }
                .ignoresSafeArea()

            Toggle(showBackdrop ? "DISABLE BLUR" : "ENABLE BLUR", isOn: $showBackdrop)
                .toggleStyle(.button)
        }
    }
}

#Preview {
    MeshTransformExample()
}
