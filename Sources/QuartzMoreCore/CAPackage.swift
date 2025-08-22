//
//  CAPackage.swift
//  QuartzMore
//
//  Created by Quentin Fasquel on 31/08/2025.
//

import Dynamic
import QuartzCore

public final class _CAPackage {
    package let instance: NSObject

    package init(_ object: NSObject) {
        self.instance = object
        
        let dynamicObject = Dynamic(object)
        geometryFlipped = dynamicObject.isGeometryFlipped ?? false
        rootLayer = dynamicObject.rootLayer
    }

    public let geometryFlipped: Bool
    public let rootLayer: CALayer!

    public convenience init(
        contentsOf fileURL: URL,
        type: _CAPackageType,
        options: [AnyHashable: Any] = [:]
    ) throws {
        let errorPointer: NSErrorPointer = nil
        let package: NSObject? = Dynamic.CAPackage.packageWithContentsOfURL(
            fileURL,
            type: type.rawValue,
            options: options,
            error: errorPointer
        )
        
        guard let package, errorPointer?.pointee == nil else {
            if let error = errorPointer?.pointee {
                throw error
            }
            fatalError()
        }

        self.init(package)
    }
}

