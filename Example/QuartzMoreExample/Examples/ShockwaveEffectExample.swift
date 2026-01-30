//
//  ShockwaveEffectExample.swift
//  ExampleQuartzMore
//
//  Created by Quentin Fasquel on 23/08/2025.
//

import QuartzMore
import QuartzMoreResources
import PhotosUI
import SwiftUI
import Turbocharger

struct ShockwaveEffectExample: View {
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var backgroundImage: Image? = Image(.background)
    @State private var stateController: _CAStateController?
    @State private var state: _CAState?
    var body: some View {
        CAPackageView(contentsOf: .CAMLBundle.shockwaveBottomUpV14CA, type: .bundle) { result in
            if case .success(let stateController) = result {
                Task { @MainActor in
                    self.stateController = stateController
                    self.state = stateController.layer.states.first
                }
            }
        }
        .ignoresSafeArea()
        .background {
            ZStack(alignment: .top) {
                OptionalAdapter(backgroundImage) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } placeholder: {
                    Color.black
                        .ignoresSafeArea()
                }

                Grid {
                    ForEach(0..<2) { rowIndex in
                        GridRow {
                            ForEach(0..<4) { colIndex in
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.thinMaterial)
                                    .aspectRatio(1, contentMode: .fit)
                            }
                        }
                    }
                }
                .padding()
                .colorScheme(.light)
            }
        }
        .allowsHitTesting(false)
//        .background {
//            OptionalAdapter(backgroundImage) { image in
//                image.resizable().scaledToFill()
//            } placeholder: {
//                Color.black
//            }
//        }
//        .ignoresSafeArea()

        .overlay {
            VStack {
                Spacer()
//                PhotosPicker(
//                    "Pick an image",
//                    selection: $photosPickerItem,
//                    matching: .images,
//                    photoLibrary: .shared()
//                )
//                .buttonStyle(.bordered)
//                .buttonBorderShape(.capsule)
//                .background(.thickMaterial, in: .capsule)

                OptionalAdapter(stateController?.layer.states) { states in
                    Picker("", selection: $state) {
                        ForEach(states.reversed()) { index, state in
                            Text(state.name)
                                .tag(state)
                        }
                    }
//                    .buttonStyle(.bordered)
                    .background(.thickMaterial, in: .capsule)
                }
            }
            .tint(.cyan)
//            .preferredColorScheme(.dark)
        }
        .onChange(of: photosPickerItem) { oldValue, newValue in
            Task { @MainActor in
                if let image = try await newValue?.loadTransferable(type: Image.self) {
                    self.backgroundImage = image
                }
            }
        }
        .onChange(of: state, initial: false) { oldValue, newValue in
            if let newValue, let stateController {
                let rootLayer = stateController.layer
                stateController.setState(newValue, of: rootLayer, transitionSpeed: 1)
            }
        }
    }
}

#Preview {
    ShockwaveEffectExample()
}
