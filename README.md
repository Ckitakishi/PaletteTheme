# PaletteTheme
A [Publish](https://github.com/johnsundell/publish) theme. [ckitakishi.com](https://ckitakishi.com) is built with `PaletteTheme`.

## Features
- Simple and fast
- Mobile friendly
- Support both Light/Dark mode
- Customisable & Extendable
- Archive articles by year
- Social items
- Support comments system
- Support Google Analytics
- ...

## Screenshot

| Desktop | Mobile |
| ------- | ------ |
| <img width="1600" alt="desktop-screenshot" src="https://user-images.githubusercontent.com/1570400/154957173-91aa07c9-3a8f-42c9-aff4-5353190865a9.png"> | <img width="600" alt="mobile-screenshot" src="https://user-images.githubusercontent.com/1570400/154957183-2776c486-7786-4cf3-ba79-d32b6d2ce237.png"> |


## Requirements

Swift version 5.5 (or later)

## Quick start

### Installation

PaletteTheme is distributed using the [Swift Package Manager](https://swift.org/package-manager/). To use it into a project, just add the following code to your `Package.swift` file:

```swift
let package = Package(
    ...
    platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/Ckitakishi/PaletteTheme.git", from: "0.2.2"),
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
// Define all sections here.
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

// Make your blog comform `PaletteCustomizable` protocol.
extension YourBlog: PaletteCustomizable {
    var pages: [PalettePage] {
        SectionID.allCases.map { $0.pageConfig }
    }
}
```

### Profile

`aboutMe`  supports Markdown syntax as well.

```swift
var aboutMe: String {
    """
    XXX is an iOS developer who has made [project 1](project1.link).
    """
}
```

Set the path to the profile icon if needed, this property is optional.

```swift
var profileIconPath: URLRepresentable? { "/profile.jpg" }
```

### Social items

You can get social icon support by simply comform the `PaletteCustomizable` protocol and defining social items as following:

```swift
extension CkitakishiPlayground: PaletteCustomizable {
    var socialItems: [SocialItem] {
        [
            .init(url: "link", type: .github),
            .init(url: "link", type: .twitter),
            .init(url: "mailto", type: .email),
        ]
    }
}
```

### Comment

`PaletteTheme`  enables you to import a comments system for your blog, currently only [giscus](https://giscus.app) is supported, the comments system could be configured by using below code. Of course, you could also add support for other comments systems to `PaletteTheme`.

```swift
var commentSystem: CommentSystem? {
    .giscus(
        script: """
        <script src="https://giscus.app/client.js"
        ...
        </script>
        """
    )
}
```

### Tracking

`PaletteTheme` supports Google Analytics by default.

```swift
var googleTrackingID: String? {
    return "YOUR_TRACKING_ID"
}
```

### Copyright

The copyright is shown in the footer. Check the defination of `Copyright` for more information.

```swift
var copyright: Copyright  {
    Copyright(owner: "Author", startYear: "2022")
}
```

## Using Plugins

### OrderedPosts

To use the post navigation at the bottom of each post, it is necessary to install the `OrderedPosts` plugin after adding markdown files.

```swift
try YourBlog().publish(using: [
    ...
    .addMarkdownFiles(),
    .installPlugin(.orderedPosts()),
    ...
])
```

## License

`PaletteTheme` is licensed under the MIT license. Check the LICENSE file for details.

### Special thanks

Special thanks to the following project:

- [tailwindcss](https://tailwindcss.com) - most of the styles are generated by tailwindcss.
- [Monokai color scheme](http://monokai.9x4.net) - code syntax highlight.
- [Base16 color scheme](https://github.com/chriskempson/base16) - main colors.
- [giscus](https://giscus.app) - comments system powered by github discussion.
