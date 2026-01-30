//
//  BackdropView.swift
//  ExampleQuartzMore
//
//  Created by Quentin Fasquel on 31/08/2025.
//

import CAFilterBuiltins
import QuartzMore
import SwiftUI

struct PageCurlExample: View {
    @State private var model = Model()

    @State private var baseTime: CGFloat = 0.0
    @State private var baseAngle: CGFloat = 0.5
    @State private var dragStartPoint: CGPoint?
    @State private var isPaused: Bool = false
    
    class Model {
        var pageCurl = _CAFilter.pageCurl()
        var layer: CALayer?
        
        init() {
            pageCurl.inputAngle = 0.5
            pageCurl.inputTime = 0.0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let _ = Self._printChanges()
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .fill(.red.gradient)
                
                TimelineView(.animation(paused: dragStartPoint == nil)) { timeline in
                    CABackdropView(filters: [model.pageCurl]) { layer in
                        model.layer = layer
                    }
                    .id(timeline.date)
                    .scaleEffect(x: -1, y: -1)
                }
            }
            .ignoresSafeArea()
            .contentShape(.rect)
            .gesture(
                DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if dragStartPoint == nil {
                        dragStartPoint = value.startLocation
                        // Capture bases at gesture start
                        baseTime = model.pageCurl.inputTime ?? 0
                        baseAngle = model.pageCurl.inputAngle ?? 0.5
                    }
                    let dx = value.translation.width
                    let dy = value.translation.height
                    
                    // Sensitivity tuning: larger divisor => slower change
                    let timeDelta = -CGFloat(dx) / 300.0
                    let angleDelta = -CGFloat(dy) / 300.0
                    
                    // Clamp to [0, 1] (adjust if your filter expects another range)
                    let newTime = clamp(baseTime + timeDelta, -1, 1)
                    let newAngle = clamp(baseAngle + angleDelta, -1, 1)
                    
                    model.pageCurl.inputTime = newTime
                    model.pageCurl.inputAngle = newAngle
                }
                .onEnded { _ in
                    dragStartPoint = nil

                    animateInputTime(
                        from: model.pageCurl.inputTime ?? 0,
                        to: 0,
                        duration: 1
                    )
                }
            )
        }
    }
    
    func animateInputTime(from: CGFloat, to: CGFloat, duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "filters.pageCurl.inputTime")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        model.layer?.add(animation, forKey: "resetInputTime")
        model.pageCurl.inputTime = to
    }
}

// Simple clamp helper
private func clamp(_ value: CGFloat, _ minVal: CGFloat, _ maxVal: CGFloat) -> CGFloat {
    min(max(value, minVal), maxVal)
}

#Preview {
    PageCurlExample()
}
