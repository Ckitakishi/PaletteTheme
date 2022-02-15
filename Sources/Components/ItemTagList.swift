//
//  ItemTagList.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Publish
import Plot

struct ItemTagList<Site: PaletteWebsite>: Component {
    let item: Item<Site>
    let site: Site

    var body: Component {
        List(item.tags) { tag in
            Link(tag.string, url: site.path(for: tag).absoluteString)
                .class("hashtag link-underline")
        }
        .class("flex flex-wrap gap-2")
    }
}

struct ItemTagListWithDate<Site: PaletteWebsite>: Component {
    let item: Item<Site>
    let site: Site
    
    var body: Component {
        Div {
            Paragraph(item.date.formattedString)
            Paragraph("|")
                .class("mx-3 text-lg -mt-0.5")
            ItemTagList(item: item, site: site)
        }
        .class("flex")
    }
}
