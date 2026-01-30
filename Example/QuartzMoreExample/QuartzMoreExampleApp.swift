//
//  QuartzMoreExampleApp.swift
//  QuartzMoreExample
//
//  Created by Quentin Fasquel on 23/08/2025.
//

import Dynamic
import SwiftUI

@main
struct QuartzMoreExampleApp: App {
#if DEBUG
    init() {
//        Dynamic.loggingEnabled = true
    }
#endif

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
