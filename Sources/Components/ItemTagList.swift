//
//  ItemTagList.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Publish
import Plot

struct ItemTagList<Site: PaletteWebsite>: Component {
    var item: Item<Site>
    var site: Site

    var body: Component {
        List(item.tags) { tag in
            Link(tag.string, url: site.path(for: tag).absoluteString)
        }
        .class("tag-list")
    }
}
