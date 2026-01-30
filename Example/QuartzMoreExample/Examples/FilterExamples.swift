//
//  VariableBlur.swift
//  ExampleQuartzMore
//
//  Created by Quentin Fasquel on 04/09/2025.
//

import CAFilterBuiltins
import CAFilterProxy
import QuartzMore
import SwiftUI
import Turbocharger

struct AlphaThresholdExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.alphaThreshold()) { filter in
            filter.inputAmount = 0.5
            filter.inputColor = UIColor.red.cgColor
        } controls: { layer, filter in
            Slider(value: layer.binding(filter, keyPath: \.inputAmount, default: 0), in: 0...1) { Text("Amount") }
        }
    }
}

struct AlphaSmoothThresholdExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.alphaSmoothThreshold()) { filter in
            filter.inputColor = UIColor.red.cgColor
        }
    }
}

struct MultiplyColorExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.multiplyColor()) { filter in
            filter.inputColor = UIColor.red.cgColor
        }
    }
}

struct ColorAddExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.colorAdd()) { filter in
            filter.inputColor = UIColor.red.cgColor
        }
    }
}

struct ColorSubtractExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.colorSubtract()) { filter in
            filter.inputColor = UIColor.blue.cgColor
        }
    }
}

struct ColorMonochromeExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.colorMonochrome()) { filter in
            filter.inputAmount = 0.5
            filter.inputBias = 0.5
            filter.inputColor = UIColor.gray.cgColor
        }
    }
}

struct ColorMatrixExample: View {
    var body: some View {
       EmptyView()
    }
}

struct ColorHueRotateExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.colorHueRotate()) { filter in
            filter.inputAngle = 10
            filter.inputHSVSpace = true
        }
    }
}

struct ColorSaturateExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.colorSaturate()) { filter in
            filter.inputAmount = 0.5
        }
    }
}

struct ColorBrightnessExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.colorBrightness()) { filter in
            filter.inputAmount = 1
        }
    }
}

struct ColorContrastExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.colorContrast()) { filter in
            filter.inputAmount = 1
        }
    }
}

struct ColorInvertExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.colorInvert()) { filter in
            // Nothing to configure
        }
    }
}

struct ColorInvertDisplayAwareExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.colorInvertDisplayAware()) { filter in
            // Nothing to configure
        }
    }
}

struct CompressLuminanceExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.compressLuminance()) { filter in
            filter.inputAmount = 1
        }
    }
}

struct OpacityPairExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.opacityPair()) { filter in
            filter.inputAmount = 1
        }
    }
}

struct MeteorExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.meteor()) { filter in
            filter.inputAmount = 10
            filter.inputScale = 2
        }
    }
}

struct SrlExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.srl()) { filter in
            filter.inputAmount = 1
        }
    }
}

struct EdrGainExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.edrGain()) { filter in
            filter.inputAmount = 10
            filter.inputScale = 2
        }
    }
}

struct EdrGainMultiplyExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.edrGainMultiply()) { filter in
            filter.inputAdaptive = true
            filter.inputAllowsGroup = true
            filter.inputAmount = 10
            filter.inputScale = 2
            filter.inputStart = 0
            filter.inputEnd = 1
        }
    }
}

struct LuminanceToAlphaExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.luminanceToAlpha()) { filter in
            filter.inputPremultipliedValues = true
        }
    }
}

struct BiasExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.bias()) { filter in
            filter.inputAmount = 1
        }
    }
}

struct DistanceFieldExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.distanceField()) { filter in
            //
        }
    }
}

struct GaussianBlurExample: View {
    var body: some View {
        CommonBody(filter: _CAFilter.gaussianBlur()) { filter in
//            filter.inputHardEdges = true
        }
    }
}

// MARK: - Variable Blur

struct VariableBlurExample: View {
    
    var body: some View {
        CommonBody(filter: _CAFilter.variableBlur()) { filter in
            filter.inputNormalizeEdges = true
            filter.inputRadius = 10
            filter.inputMaskImage = .mask(
                .linearGradient(colors: [.black, .clear, .clear], startPoint: .top, endPoint: .bottom),
                in: .init(x: 0, y: 0, width: 100, height: 100)
            )
        } controls: { layer, filter in
            Toggle("Dither", isOn: layer.binding(filter, keyPath: \.inputDither, default: false))
            Toggle("Fade", isOn: layer.binding(filter, keyPath: \.inputFade, default: false))
            Toggle("Normalize Edges", isOn: layer.binding(filter, keyPath: \.inputNormalizeEdges, default: false))
            Toggle("Normalize Edges Transparent", isOn: layer.binding(filter, keyPath: \.inputNormalizeEdgesTransparent, default: false))
            Slider(value: layer.binding(filter, keyPath: \.inputRadius, default: 0), in: 0...100)
        }
    }
}
struct CenteredScrollView<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Spacer()
                    content()
                    Spacer()
                }
                .frame(width: geometry.size.width)
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}
struct GlassBackgroundExample: View {
    var body: some View {
       EmptyView()
    }
}

struct GlassForegroundExample: View {
    var body: some View {
       EmptyView()
    }
}

struct ChromaticAberrationExample: View {
    var body: some View {
       EmptyView()
    }
}

struct ChromaticAberrationMapExample: View {
    var body: some View {
       EmptyView()
    }
}

struct DisplacementMapExample: View {
    var body: some View {
       EmptyView()
    }
}

struct LuminanceMapExample: View {
    var body: some View {
       EmptyView()
    }
}

struct LuminanceCurveMapExample: View {
    var body: some View {
       EmptyView()
    }
}

struct CurvesExample: View {
    var body: some View {
       EmptyView()
    }
}

struct AverageColorExample: View {
    var body: some View {
       EmptyView()
    }
}

struct LanczosResizeExample: View {
    var body: some View {
       EmptyView()
    }
}

// PageCurlExample.swift

struct SdrNormalizeExample: View {
    var body: some View {
       EmptyView()
    }
}

struct VibrantDarkExample: View {
    var body: some View {
       EmptyView()
    }
}

struct VibrantLightExample: View {
    var body: some View {
       EmptyView()
    }
}

struct VibrantColorMatrixExample: View {
    var body: some View {
       EmptyView()
    }
}

struct LimitAveragePixelLuminanceExample: View {
    var body: some View {
       EmptyView()
    }
}

struct LutExample: View {
    var body: some View {
       EmptyView()
    }
}

struct VibrantColorMatrixSourceOverExample: View {
    var body: some View {
       EmptyView()
    }
}

// MARK: -

struct FilterExamplePicker: View {
    @State var filterType: CAFilterType = .multiplyColor

    var body: some View {
        TabView(selection: $filterType) {
            ForEach(CAFilterType.allCases, id: \.id) { filterType in
                filterType.makeExample()
                    .tag(filterType)
            }
        }
        .tabViewStyle(.page)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
        .colorScheme(.dark)
        .toolbar {
            ToolbarItem(placement: .title) {
                Picker("", selection: $filterType) {
                    ForEach(CAFilterType.allCases, id: \.self) { filter in
                        Text(filter.displayTitle)
                            .tag(filter)
                    }
                }
                .font(.title2.bold())
                .tint(.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        FilterExamplePicker()
    }
}

// MARK: -

extension CGImage {
    
    static func mask<T>(_ mask: T, in rect: CGRect) -> CGImage? where T: Shape {
        fatalError()
    }

    static func mask(_ mask: LinearGradient, in rect: CGRect) -> CGImage? {
        let view = mask.frame(width: rect.width, height: rect.height)
        return ImageRenderer(content: view).cgImage
    }
    
    static func mask(_ mask: RadialGradient, in rect: CGRect) -> CGImage? {
        let view = mask.frame(width: rect.width, height: rect.height)
        return ImageRenderer(content: view).cgImage
    }
}


struct AutosizingSheetForm: ViewModifier {
    @State private var contentHeight: CGFloat = 0
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .scrollBounceBehavior(.basedOnSize)
            .onScrollGeometryChange(for: CGSize.self, of: { $0.contentSize }) { _, newValue in
                contentHeight = newValue.height
            }
            .interactiveDismissDisabled()
            .presentationBackgroundInteraction(.enabled)
            .presentationBackground(.thinMaterial)
            .presentationDragIndicator(.hidden)
            .presentationCornerRadius(56)
            .presentationDetents([.height(contentHeight)])
            .tint(.pink)
    }
}

extension View {
    @ViewBuilder func autosizingSheetForm() -> some View {
        modifier(AutosizingSheetForm())
    }
}

class M {
    var layer: CALayer?
}

struct DefaultContent: View {
    var body: some View {
        Image(.background)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

struct CommonBody<T, Content: View, Controls: View>: View {
    @State private var m = M()
    @State private var showControls: Bool = false

    var filter: T
    var applying: (T) -> Void

    @ViewBuilder var controls: (CALayer, T) -> Controls
    @ViewBuilder var content: () -> Content

    init(
        filter: T,
        applying: @escaping (T) -> Void,
    ) where Controls == EmptyView, Content == DefaultContent {
        self.filter = filter
        self.applying = applying
        self.controls = { _, _ in EmptyView() }
        self.content = { DefaultContent() }
    }

    init(
        filter: T,
        applying: @escaping (T) -> Void,
        @ViewBuilder controls: @escaping (CALayer, T) -> Controls,
    ) where Content == DefaultContent {
        self.filter = filter
        self.applying = applying
        self.controls = controls
        self.content = { DefaultContent() }
    }


    init(
        filter: T,
        applying: @escaping (T) -> Void,
        @ViewBuilder content: @escaping () -> Content,
    ) where Controls == EmptyView {
        self.filter = filter
        self.applying = applying
        self.controls = { _, _ in EmptyView() }
        self.content = content
    }

    var body: some View {
        CALayerHosting {
            content()
        } onLayer: { layer in
            applying(filter)
            layer.filters = [filter]
            m.layer = layer
        }
        .ignoresSafeArea()
        .onTapGesture { showControls.toggle() }
        .sheet(isPresented: $showControls) {
            Form {
                if m.layer != nil {
                    Group { controls(m.layer!, filter) }
                        .listRowBackground(Color.clear)
                } else {
                    Color.red
                }
            }
            .autosizingSheetForm()
        }
    }
}

struct CALayerHosting<Content: View>: UIViewControllerRepresentable {
    @ViewBuilder var content: Content
    var onLayer: (CALayer) -> Void
    func makeUIViewController(context: Context) -> UIHostingController<Content> {
        let hosting = UIHostingController(rootView: content)
        print("init", hosting.view.layer)
        onLayer(hosting.view.layer)
        return hosting
    }
    func updateUIViewController(_ hosting: UIHostingController<Content>, context: Context) {
        hosting.rootView = content
    }
}



extension CALayer {
    func binding<T, V>(
        _ filter: T,
        keyPath: ReferenceWritableKeyPath<T, V?>,
        default: V
    ) -> Binding<V> {
        return Binding<V> {
            filter[keyPath: keyPath] ?? `default`
        } set: { newValue in
            filter[keyPath: keyPath] = newValue
            // Force refreshing
            self.filters = []
            self.filters = [filter]
        }

    }
}

extension _CAFilter {
    var name: String {
        value(forKey: "name") as! String
    }

    var _rawValue: NSObject {
        target as! NSObject
    }
}
