//
//  PlatformColor.swift
//  QuartzMoreExample
//
//  Created by Quentin Fasquel on 14/12/2025.
//

#if os(iOS)
import UIKit
typealias PlatformColor = UIColor
#elseif os(macOS)
import AppKit
typealias PlatformColor = NSColor
#endif
