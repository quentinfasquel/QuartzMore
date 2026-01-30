//
//  MeshTransformExample.swift
//  QuartzMoreExample
//
//  Created by Quentin Fasquel on 18/10/2025.
//

import QuartzMore
import SwiftUI

import Dynamic
import Combine

class MeshTransformAnimator: ObservableObject {
    private var displayLink: CADisplayLink?
    private var meshTransform: _CAMutableMeshTransform?
    private var layer: CALayer?
    private var startTime: CFTimeInterval = 0
    
    func startAnimation(with meshTransform: _CAMutableMeshTransform, layer: CALayer) {
        self.meshTransform = meshTransform
        self.layer = layer
        self.startTime = CACurrentMediaTime()
        
#if os(iOS)
        displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
        displayLink?.add(to: .main, forMode: .common)
#endif
    }
    
    func stopAnimation() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func updateAnimation() {
        guard let meshTransform = meshTransform,
              let layer = layer else { return }
        
        let currentTime = CACurrentMediaTime()
        let elapsed = currentTime - startTime
        
        // Animate in a circle - we'll move vertex at position (1,1)
        let radius: Double = 0.4 // Adjust radius as needed
        let speed: Double = 0.1 // Revolutions per second
        let angle = elapsed * speed * 2.0 * Double.pi
        
        let offsetX = Double(cos(angle)) * radius
        let offsetY = Double(sin(angle)) * radius
        
        // Update the vertex at grid position (1,1) to move in a circle
        let vertexIndex = 1 * 4 + 1 // width=4, so index = y*width + x
        var v = meshTransform.vertex(at: vertexIndex)
        v.position.x = 0.33 + offsetX
        v.position.y = 0.33 + offsetY

//        v.point3D.x = 0.25 + offsetX
//        v.point3D.y = 0.25 + offsetY
        meshTransform.replaceVertex(at: vertexIndex, with: v)
        
        // Trigger layer update
//        layer.setNeedsDisplay()
        layer._meshTransform = meshTransform
    }
    
    deinit {
        stopAnimation()
    }
}


struct MeshTransformExample: View {
    @State private var animator = WaterMeshTransformAnimator()
    
    var body: some View {
        GeometryReader { geometry in
            DefaultContent()
                .meshTransform(width: 4, height: 4) { layer, meshTransform in
                    animator.startAnimation(on: layer, with: meshTransform)
                }
        }
        .ignoresSafeArea()
        .onDisappear {
            animator.stopAnimation()
        }
    }
}

#Preview {
    MeshTransformExample()
}

@Observable
public final class WaterMeshTransformAnimator {
    private var displayLink: CADisplayLink?
    private var meshTransform: _CAMutableMeshTransform?
    private var layer: CALayer?
    private var startTime: CFTimeInterval = 0
    
    // Water animation parameters - make them adjustable
    var waveSpeed: Double = 0.1
    var waveAmplitude: Double = 0.2
    var waveFrequency: Double = 10.0
    var rippleSpeed: Double = 0.5
    var rippleAmplitude: Double = 0.4
    var enableRipples: Bool = false
    var enableZMovement: Bool = false
    
    public init() {}
    
    public func startAnimation(on layer: CALayer, with meshTransform: _CAMutableMeshTransform) {
        self.meshTransform = meshTransform
        self.layer = layer
        self.startTime = CACurrentMediaTime()
        
#if os(iOS)
        displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
        displayLink?.add(to: .main, forMode: .common)
#endif
    }
    
    func stopAnimation() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func updateAnimation() {
        guard let meshTransform = meshTransform,
              let layer = layer else { return }
        
        let currentTime = CACurrentMediaTime()
        let elapsed = currentTime - startTime
        
        let meshWidth = 4
        let meshHeight = 4
        
        // Animate all vertices to create water-like movement
        for y in 0..<meshHeight {
            for x in 0..<meshWidth {
                let vertexIndex = y * meshWidth + x
                var vertex = meshTransform.vertex(at: vertexIndex)
                
                // Calculate normalized coordinates (0.0 to 1.0)
                let normalizedX = Double(x) / Double(meshWidth - 1)
                let normalizedY = Double(y) / Double(meshHeight - 1)
                
                // Original position
                let originalX = normalizedX
                let originalY = normalizedY
                
                // Check if vertex is on the edge - if so, keep it stationary
                let isOnEdge = x == 0 || x == meshWidth - 1 || y == 0 || y == meshHeight - 1
                
                if false {
                    // Keep edge vertices at their original positions
                    vertex.point3D.x = originalX
                    vertex.point3D.y = originalY
                    vertex.point3D.z = 0.0
                } else {
                    // Apply water animation to interior vertices only
                    
                    // Wave 1: Horizontal waves moving vertically
                    let wave1 = sin((normalizedY * waveFrequency + elapsed * waveSpeed) * 2.0 * Double.pi) * waveAmplitude
                    
                    // Wave 2: Vertical waves moving horizontally
                    let wave2 = sin((normalizedX * waveFrequency + elapsed * waveSpeed * 1.2) * 2.0 * Double.pi) * waveAmplitude * 0.7
                    
                    // Wave 3: Diagonal waves
                    let diagonal = normalizedX + normalizedY
                    let wave3 = sin((diagonal * waveFrequency * 0.8 + elapsed * waveSpeed * 0.8) * 2.0 * Double.pi) * waveAmplitude * 0.5
                    
                    // Create fade-out factor based on distance from edges
                    let edgeFadeX = min(normalizedX, 1.0 - normalizedX) * 2.0 // 0 at edges, 1 at center
                    let edgeFadeY = min(normalizedY, 1.0 - normalizedY) * 2.0 // 0 at edges, 1 at center
                    let edgeFade = min(edgeFadeX, edgeFadeY) // Overall fade factor
                    
                    // Combine wave effects with edge fade
                    let finalOffsetX = (wave2 + wave3 * 0.5) * edgeFade
                    var finalOffsetY = (wave1 + wave3 * 0.5) * edgeFade
                    
                    // Optional ripple effect from center
                    if enableRipples {
                        let centerX = 0.5
                        let centerY = 0.5
                        let distanceFromCenter = sqrt(pow(normalizedX - centerX, 2) + pow(normalizedY - centerY, 2))
                        let ripple = sin((distanceFromCenter * 8.0 - elapsed * rippleSpeed * 4.0) * 2.0 * Double.pi) * rippleAmplitude * (1.0 - distanceFromCenter)
                        finalOffsetY += ripple * edgeFade
                    }
                    
                    // Apply the transformations
                    vertex.position.x = isOnEdge ? originalX : originalX + sin(elapsed) * 0.1
                    vertex.position.y = isOnEdge ? originalY : originalY + sin(elapsed) * 0.1
                    vertex.point3D.x = originalX + finalOffsetX
                    vertex.point3D.y = originalY + finalOffsetY
                    
                    // Optional: Add subtle Z movement for more depth
                    if enableZMovement {
                        vertex.point3D.z = (wave1 + wave2) * 0.02 * edgeFade
                    }
                }
                
                meshTransform.replaceVertex(at: vertexIndex, with: vertex)
            }
        }
        
        // Trigger layer update
        layer._meshTransform = meshTransform
    }
    
    deinit {
        stopAnimation()
    }
}
