# QuartzMore

**QuartzMore** is an experimental Swift package that provides **lightweight, type-safe wrappers around Core Animation private APIs**.

The goal of the project is **exploration, education, and research**: to make it easier to understand, experiment with, and prototype functionality that exists in Core Animation but is not publicly exposed by Apple.

## ⚠️ **Important Notice**

This repository uses **private Core Animation APIs** accessed dynamically at runtime.
**Nothing in this project is intended for production use or App Store distribution.**
This code exists purely for **educational and research purposes**.


## 🔥 Motivation

Core Animation contains a wealth of powerful internal features—mesh transforms, filters, layer states, portals, behaviors—that are not publicly documented or exposed.

QuartzMore aims to:

- Expose these APIs through **clean, Swifty, type-safe interfaces**
- Avoid fragile Objective-C stringly-typed usage where possible
- Provide **reference implementations** for learning how these systems work
- Enable experimentation and prototyping in **debug, research, or internal tools**

If you enjoy reverse-engineering, Core Animation internals, or graphics experimentation, this project is for you.

## Scope & Philosophy

QuartzMore is intentionally:

- ✅ **Thin** – minimal abstraction over the underlying private APIs
- ✅ **Explicit** – private behavior is clearly labeled and isolated
- ✅ **Unsafe by design** – because private APIs are inherently unsafe
- ❌ **Not stable** – APIs may change without notice
- ❌ **Not App Store safe**

If you need something robust or shippable, this is **not** the right library.

## Features

### Core Animation Wrappers

- **`_CAMeshTransform`**
  - Type-safe mesh data structures:
    	`CAPoint3D`, `CAMeshVertex`, `CAMeshFace`
  - Thin proxy over the private `_CAMeshTransform`
  - Easy integration with `CALayer` via `_meshTransform`
  - Depth normalization options via `CADepthNormalization`

- **`_CAFilter`**
  - Strongly-typed wrappers for Core Animation filters
  - Depends on [CAFilterBuiltins](https://github.com/quentinfasquel/CAFilterBuiltins) for filter definitions and metadata

- **`_CAPackage`**
  - Swift-friendly access to Core Animation package layers
  - Useful for experimenting with archived animation trees

## SwiftUI Integration

QuartzMore also includes **SwiftUI helpers** for experimentation:

- SwiftUI views that host private Core Animation layers
- View modifiers to apply private layer effects
- Bridges between SwiftUI and Core Animation internals

> These are meant for **exploration and debugging**, not production SwiftUI apps.


## Getting Started

### Requirements

- Xcode 15+
- Swift 5.9+
- iOS / macOS platform with QuartzCore available

> Tested primarily on recent Apple OS releases. Older systems may behave differently.

### Installation

Add QuartzMore as a **local Swift package**, or copy the sources directly into your project.

Because this project relies on private APIs:

- Do **not** distribute it via Swift Package Index
- Do **not** embed it in App Store builds
- Prefer **debug-only targets or internal tools**

---

## 🚀 Usage

### Creating a Mesh Transform

```swift
import QuartzCore
import QuartzMore

// Define vertices (2D position + 3D depth)
let vertices: [CAMeshVertex] = [
    CAMeshVertex(position: CGPoint(x: 0, y: 0), point3D: CAPoint3D(x: 0, y: 0, z: 0)),
    CAMeshVertex(position: CGPoint(x: 1, y: 0), point3D: CAPoint3D(x: 0, y: 0, z: 0)),
    CAMeshVertex(position: CGPoint(x: 0, y: 1), point3D: CAPoint3D(x: 0, y: 0, z: 0)),
    CAMeshVertex(position: CGPoint(x: 1, y: 1), point3D: CAPoint3D(x: 0, y: 0, z: 0)),
]

// Define a single quad face referencing the 4 vertices
let faces: [CAMeshFace] = [
    CAMeshFace(
        indices: (0, 1, 3, 2),
        weights: (1, 1, 1, 1)
    )
]

let mesh = _CAMeshTransform(
    vertexCount: vertices.count,
    vertices: vertices,
    faceCount: faces.count,
    faces: faces,
    depthNormalization: .none
)
```

## 🔮 Roadmap

- [x] `CAFilter` (via `CAFilterBuiltins`)
- [x] `CAPackage`
- [x] `CAMeshTransform`
- [ ] Emitter layer behaviors (`CAEmitterBehavior`)
- [ ] Layer state machines & internal controllers
- [ ] Additional private Core Animation layer subclasses (`CAPortalLayer`, etc.)
- [ ] More SwiftUI experimentation helpers

## See Also

- [CAFilterBuiltins](https://github.com/quentinfasquel/CAFilterBuiltins)

---

## 📜 License

This project is licensed under the [MIT License](LICENSE) © 2025 Quentin Fasquel.
