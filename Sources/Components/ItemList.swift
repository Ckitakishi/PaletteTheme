//
//  ItemList.swift
//
//  Used on Writing view.
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Publish
import Plot

struct ItemList<Site: PaletteWebsite>: Component {
    var items: [Item<Site>]
    var site: Site

    var body: Component {
        List(items) { item in
            Article {
                H1(Link(item.title, url: item.path.absoluteString))
                ItemTagList(item: item, site: site)
                Paragraph(item.description)
            }
            .class("prose")
        }
        .class("item-list")
    }
}
