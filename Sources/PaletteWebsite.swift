//
//  PaletteWebsite.swift
//  
//
//  Created by Yuhan Chen on 2022/02/12.
//

import Publish
import Plot

/// Conform to these protocols makes you can customize many additional configurations.
public typealias PaletteWebsite = Website & PaletteCustomizable

/// Protocol that defines all customisable configurations for Palette theme.
public protocol PaletteCustomizable {
    /// The `PalettePage`s that the website will include.
    var pages: [PalettePage] { get }
    /// The social items will be shown on website.
    var socialItems: [SocialItem] { get }
    /// The path to profile icon.
    var profileIconPath: URLRepresentable? { get }
    /// The copyright of website.
    var copyright: String { get }
    /// The comment system used on website, currently only giscus is supported.
    var commentSystem: CommentSystem? { get }
}

public extension PaletteCustomizable {
    var profileIconPath: URLRepresentable? { nil }
    var socialItems: [SocialItem] { [] }
}

/// Type used to represent a Palette section.
/// Some configurations of page can be defined within this type.
public struct PalettePage: Equatable {
    public enum ItemListType {
        case `default`
        case groupByYear
    }
    
    /// An unique id of section.
    let id: String
    /// The text for display on the navigation bar.
    let title: String
    /// The URL to each secion's page.
    let link: URLRepresentable
    /// Represents whether an item is for home page, default is `false`
    let isIndex: Bool
    /// A type used to specific the style of list.
    let listType: ItemListType
    
    public init(
        id: String,
        title: String,
        link: URLRepresentable,
        isIndex: Bool = false,
        listType: ItemListType = .default
    ) {
        self.id = id
        self.title = title
        self.link = link
        self.isIndex = isIndex
        self.listType = listType
    }
    
    public static func == (lhs: PalettePage, rhs: PalettePage) -> Bool {
        lhs.id == rhs.id
    }
}

/// A enum represents the comments system.
public enum CommentSystem {
    case giscus(script: String)
    
    /// The related class name of comments system.
    public var className: String? {
        switch self {
        case .giscus:
            return "giscus"
        }
    }
}
