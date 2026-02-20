//
//  _CAFilter.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 20/02/2026.
//

import QuartzMoreCore

// MARK: - Equatable

extension _CAFilter: Equatable {
    public static func == (lhs: _CAFilter, rhs: _CAFilter) -> Bool {
        lhs === rhs
    }
}
