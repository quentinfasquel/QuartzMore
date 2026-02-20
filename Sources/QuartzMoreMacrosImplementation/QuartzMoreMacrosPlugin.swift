//
//  QuartzMoreMacrosPlugin.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 15/02/2026.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct QuartzMoreMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DynamicLookupMacro.self,
    ]
}
