//
//  CAFilterMacros.swift
//  CAFilterBuiltinsMacros
//
//  Created by Quentin Fasquel on 01/09/2025.
//

@attached(accessor)
public macro DynamicLookup() = #externalMacro(
    module: "QuartzMoreMacrosImplementation",
    type: "DynamicLookupMacro"
)
