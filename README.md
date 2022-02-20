# PaletteTheme
A [Publish](https://github.com/johnsundell/publish) theme.

## Features
- Simple and fast
- Mobile-friendly
- Support both Light/Dark mode
- Customisable & Extendable
- Archive articles by year
- Social items
- Support Markdown description
- [ ] Table of contents
- [ ] Support comments
- [ ] ...

## Screenshot

| Desktop | Mobile |
| ------- | ------ |
| | |

## Requirements

Swift version 5.5 (or later)

## Quick start

### Installation

PaletteTheme is distributed using the [Swift Package Manager](https://swift.org/package-manager/). To install it into a project, just add the following code to your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/Ckitakishi/PaletteTheme.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "YourBlog",
            dependencies: ["PaletteTheme"]
        )
    ]
    ...
)
```

## Usage

Import `PaletteTheme` wherever you’d like to use it:

```swift
import PaletteTheme
```

## Configuration

Use theme `.palette` to generate HTML:

```swift
try YourBlog().publish(using: [
    ...
    .generateHTML(withTheme: .palette),
    ...
])
```

### Sections

Add the sections that you want your website to contain in `SectionID` enum. And you can customize the section by initializing `PalettePage` like below:

```swift
// Define all sections here:
enum SectionID: String, WebsiteSectionID {
    case home
    case posts
    ...
        
    var pageConfig: PalettePage {
        switch self {
        case .home:
            return .init(
                id: self.rawValue,  // Should be unique
                title: "Home",      // Section title shown on navigation bar
                link: "/",          // The path of section
                isIndex: true       // Represents whether an item is for home page, default is `false`
            )
        case .posts:
            return .init(
                id: self.rawValue,
                title: "Writing",
                link: "/posts"
            )
        ...
        }
    }
}

// Make your blog adopt `PaletteCustomizable` protocol:
extension YourBlog: PaletteCustomizable {
    var pages: [PalettePage] {
        SectionID.allCases.map { $0.pageConfig }
    }
}
```

### Description

Description supports Markdown syntax as well:

```swift
var description = """
XXX is an iOS developer who has made [project 1](project1.link).
"""
```

### Social items

You can get social icon support by simply adopt the `PaletteCustomizable` protocol and defining social items as following:

```swift
extension CkitakishiPlayground: PaletteCustomizable {
    var socialItems: [SocialItem] {
        [
            .init(url: "link", type: .github),
            .init(url: "link", type: .linkedin),
            .init(url: "link", type: .twitter),
            .init(url: "link", type: .instagram),
            .init(url: "address", type: .email),
        ]
    }
}
```
