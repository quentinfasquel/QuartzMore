//
//  PortalViewExample.swift
//  QuartzMoreExample
//
//  Created by Quentin Fasquel on 17/02/2026.
//

import QuartzMore
import SwiftUI

struct PortalViewExample: View {
    @Namespace private var namespace
    @State private var showBlop2: Bool = true
        
    var body: some View {
        let content = Image(systemName: "sun.horizon.fill")
            .font(.largeTitle)
            .scaleEffect(2)
            .symbolRenderingMode(.multicolor)
            .symbolEffect(.breathe, isActive: true)
            .frame(width: 100, height: 100)
            .padding()
            .background(.black.gradient, in: .rect(topLeadingRadius: 12, topTrailingRadius: 12))
        
        VStack(spacing: 0) {
            content
                .portalSource(id: "source", in: namespace)
                .overlay(alignment: .bottom) {
                    Text("Source View")
                        .padding(.bottom, 8)
                }
            
            PortalView(sourceID: "source", namespace: namespace)
                .scaleEffect(y: -1)
                .mask(LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom))
                .opacity(0.5)
                .overlay(alignment: .top) {
                    Text("Portal View")
                        .padding(.top, 8)
                }
                .portalSource(id: showBlop2 ? "blop2" : "none", in: namespace)
            
            if showBlop2 {
                PortalView(sourceID: "blop2", namespace: namespace)
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.secondary)
        .contentShape(.rect)
        .onTapGesture {
            showBlop2.toggle()
        }
    }
}

#Preview {
    PortalViewExample()
}
