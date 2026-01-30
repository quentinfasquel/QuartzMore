
//
//  Resources.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 24/08/2025.
//

import Foundation

extension URL {
    enum CAMLBundle {
        static var shockwaveBottomUpV14CA: URL {
            // This file can be obtained from the iOS Simulator runtime. Observed path (for reference only):
            // runtime path: "/Library/Developer/CoreSimulator/Volumes/iOS\_(xxx)/Library/Developer/CoreSimulator/Profiles/Runtimes/(...)/RuntimeRoot"
            // file path: "/Applications/AirDropUI.app/shockwave-bottomup-v14.c"
            return Bundle.main.url(forResource: "shockwave-bottomup-v14", withExtension: "ca")!
        }
    }
}
