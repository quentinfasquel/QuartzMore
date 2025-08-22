//
//  CALayer.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 31/08/2025.
//

import Dynamic
import QuartzCore

extension CALayer {

    public var states: [_CAState] {
        return Dynamic(self).states.asArray?.compactMap {
            guard let state = $0 as? NSObject else {
                return nil
            }
            return _CAState(state)
        } ?? []
    }
}
