//
//  CAFilterTypeExamples.swift
//  ExampleQuartzMore
//
//  Created by Quentin Fasquel on 04/09/2025.
//

import CAFilterBuiltins
import SwiftUI

extension CAFilterType: @retroactive Identifiable {
    public var id: String {
        rawValue
    }

    var displayTitle: String {
        rawValue.camelCaseToCapitalized()
    }
    
    var isDisabled: Bool {
        switch self {
        case .gaussianBlur, .variableBlur:
            false
        default:
            true
        }
    }
    
    @ViewBuilder func makeExample() -> some View {
        switch self {
        case .alphaThreshold:
            AlphaThresholdExample()
        case .alphaSmoothThreshold:
            AlphaSmoothThresholdExample()
        case .multiplyColor:
            MultiplyColorExample()
        case .colorAdd:
            ColorAddExample()
        case .colorSubtract:
            ColorSubtractExample()
        case .colorMonochrome:
            ColorMonochromeExample()
        case .colorMatrix:
            ColorMatrixExample()
        case .colorHueRotate:
            ColorHueRotateExample()
        case .colorSaturate:
            ColorSaturateExample()
        case .colorBrightness:
            ColorBrightnessExample()
        case .colorContrast:
            ColorContrastExample()
        case .colorInvert:
            ColorInvertExample()
        case .colorInvertDisplayAware:
            ColorInvertDisplayAwareExample()
        case .compressLuminance:
            CompressLuminanceExample()
        case .opacityPair:
            OpacityPairExample()
        case .meteor:
            MeteorExample()
        case .srl:
            SrlExample()
        case .edrGain:
            EdrGainExample()
        case .edrGainMultiply:
            EdrGainMultiplyExample()
        case .luminanceToAlpha:
            LuminanceToAlphaExample()
        case .bias:
            BiasExample()
        case .distanceField:
            DistanceFieldExample()
        case .gaussianBlur:
            GaussianBlurExample()
        case .variableBlur:
            VariableBlurExample()
        case .glassBackground:
            GlassBackgroundExample()
        case .glassForeground:
            GlassForegroundExample()
        case .chromaticAberration:
            ChromaticAberrationExample()
        case .chromaticAberrationMap:
            ChromaticAberrationMapExample()
        case .displacementMap:
            DisplacementMapExample()
        case .luminanceMap:
            LuminanceMapExample()
        case .luminanceCurveMap:
            LuminanceCurveMapExample()
        case .curves:
            CurvesExample()
        case .averageColor:
            AverageColorExample()
        case .lanczosResize:
            LanczosResizeExample()
        case .pageCurl:
            PageCurlExample()
        case .sdrNormalize:
            SdrNormalizeExample()
        case .vibrantDark:
            VibrantDarkExample()
        case .vibrantLight:
            VibrantLightExample()
        case .vibrantColorMatrix:
            VibrantColorMatrixExample()
        case .limitAveragePixelLuminance:
            LimitAveragePixelLuminanceExample()
        case .lut:
            LutExample()
        case .vibrantColorMatrixSourceOver:
            VibrantColorMatrixSourceOverExample()
        }
    }
}
