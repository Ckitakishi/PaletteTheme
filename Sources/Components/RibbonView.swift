//
//  RibbonView.swift
//  
//
//  Created by Yuhan Chen on 2022/02/21.
//

import Plot

struct RibbonView: Component {
    var body: Component {
        Div {
            for colorCode in Constant.base16BgColors {
                Div().class(colorCode)
            }
        }
        .class("grid grid-cols-8 w-full h-[8px]")
    }
}


