//
//  Resources.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 24/08/2025.
//

import Foundation

public extension URL {
    enum CAMLBundle {
        public static var shockwaveBottomUpV14CA: URL {
            Bundle.module.resourceURL!.appending(component: "shockwave-bottomup-v14.ca")
        }
    }
}
