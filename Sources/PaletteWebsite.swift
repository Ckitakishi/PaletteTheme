//
//  PaletteWebsite.swift
//  
//
//  Created by Yuhan Chen on 2022/02/12.
//

import Foundation
import Publish
import Plot

public protocol PaletteWebsite: Website, PaletteCustomizable { }

public protocol PaletteCustomizable {
    var pages: [PalettePage] { get }
}

public struct PalettePage: Equatable {
    public enum ItemListType {
        case `default`
        case groupByYear
    }
    
    let id: String
    let title: String
    let link: URLRepresentable
    let isIndex: Bool // Represents whether an item is for home page, default is `false`
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
