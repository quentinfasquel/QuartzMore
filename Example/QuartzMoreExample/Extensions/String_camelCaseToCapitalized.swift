//
//  String_camelCaseTo.swift
//  ExampleQuartzMore
//
//  Created by Quentin Fasquel on 04/09/2025.
//

import Foundation

extension String {
    /// Converts a camelCase string to a properly capitalized string with spaces
    /// Example: "alphaThreshold" -> "Alpha Threshold"
    func camelCaseToCapitalized(spaces: Bool = true) -> String {
        // Handle empty strings
        guard !isEmpty else { return self }
        
        // Insert spaces before uppercase letters (except the first character)
        let spacedString = self.replacingOccurrences(
            of: "([a-z])([A-Z])",
            with: "$1 $2",
            options: .regularExpression
        )
        
        // Capitalize the first letter of each word
        if spaces {
            return spacedString.capitalized
        } else {
            return spacedString.capitalized.replacingOccurrences(of: " ", with: "")
        }
    }
}
