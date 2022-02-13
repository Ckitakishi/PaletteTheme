//
//  Theme+Palette.swift
//  
//
//  Created by Yuhan Chen on 2022/01/23.
//

import Publish
import Plot

public extension Theme where Site: PaletteWebsite {
    static var palette: Self {
        Theme(
            htmlFactory: PaletteThemeHTMLFactory(),
            resourcePaths: ["Resources/styles.css"]
        )
    }
}
