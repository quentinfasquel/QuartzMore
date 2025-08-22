//
//  CAState.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 31/08/2025.
//

import Dynamic
import QuartzCore

public struct _CAState: Equatable, Hashable {
    package let instance: NSObject

    package init(_ object: NSObject) {
        self.instance = object
    }

    public var name: String {
        Dynamic(instance).name.asString ?? ""
    }
}
