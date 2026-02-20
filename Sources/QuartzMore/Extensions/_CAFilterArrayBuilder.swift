//
//  CAFilterArrayBuilder.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 20/02/2026.
//

import QuartzMoreCore

@resultBuilder
public enum _CAFilterArrayBuilder {
    public static func buildBlock(_ components: [_CAFilter]...) -> [_CAFilter] { components.flatMap { $0 } }
    public static func buildArray(_ components: [[_CAFilter]]) -> [_CAFilter] { components.flatMap { $0 } }
    public static func buildOptional(_ component: [_CAFilter]?) -> [_CAFilter] { component ?? [] }
    public static func buildEither(first component: [_CAFilter]) -> [_CAFilter] { component }
    public static func buildEither(second component: [_CAFilter]) -> [_CAFilter] { component }
    public static func buildExpression(_ expression: _CAFilter) -> [_CAFilter] { [expression] }
    public static func buildExpression(_ expression: [_CAFilter]) -> [_CAFilter] { expression }
    public static func buildLimitedAvailability(_ component: [_CAFilter]) -> [_CAFilter] { component }
}
