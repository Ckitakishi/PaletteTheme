//
//  PostNavigationBar.swift
//  
//
//  Created by Yuhan Chen on 2022/03/01.
//

import Plot
import Publish

public struct PostNavigationBar<Site: PaletteWebsite>: Component {
    let item: Item<Site>
    
    public var body: Component {
        Div {
            if let previous = item.previous {
                Div {
                    Div("←").class("self-center")
                    UnderlineButton(title: "\(previous.title)", url: previous.pathString)
                        .class("text-xl")
                }
                .class("flex gap-2 w-5/12 self-center")
            }
            if let next = item.next {
                Div {
                    Div("→").class("self-center")
                    UnderlineButton(title: "\(next.title)", url: next.pathString)
                        .class("text-xl")
                }
                .class("flex flex-row-reverse gap-2 w-5/12 self-center")
            }
        }
        .class("flex justify-between text-xl")
    }
}
