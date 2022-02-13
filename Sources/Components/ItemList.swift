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
                H3(Link(item.title, url: item.path.absoluteString))
                    .class("font-semibold")
                Paragraph(item.description)
                    .class("text-zinc-500")
                ItemTagListWithDate(item: item, site: site)
                    .class("text-zinc-600 mt-6")
            }
            .class("bg-zinc-100 rounded-lg my-6 p-6")
        }
    }
}
