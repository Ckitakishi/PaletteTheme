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
                    .class("mt-2")
                    .class("text-zinc-500 dark:text-zinc-400")
                ItemTagListWithDate(item: item, site: site)
                    .class("mt-8")
            }
            .class("rounded-lg my-6 p-6")
            .class("bg-zinc-100 dark:bg-zinc-800")
        }
    }
}

struct GroupByYearItemList<Site: PaletteWebsite>: Component {
    let items: [Item<Site>]
    let site: Site
    
    private var groupByYear: [Int: [Item<Site>]] {
        var itemsDic: [Int: [Item<Site>]] = [:]
        items.forEach { item in
            let year = item.date.year
            var itemsOfYear = itemsDic[year] ?? []
            itemsOfYear.append(item)
            itemsDic[year] = itemsOfYear
        }
        return itemsDic
    }
    private var sortedYears: [Int] { groupByYear.keys.sorted(by: >) }

    var body: Component {
        List(sortedYears) { year in
            let sortedArticles = groupByYear[year]?.sorted(by: \.date, ascending: false) ?? []
            return Div {
                H2("\(year)").class("top-h2")
                List(sortedArticles) { item in
                    Div {
                        Span("\(item.date.formattedString)")
                            .class("flex-none w-32 text-zinc-500")
                        Span(Link(item.title, url: item.path.absoluteString))
                            .class("flex-3 link-underline")
                    }
                    .class("flex my-2")
                }
                .class("group-item-list")
            }
        }
        .class("space-y-16")
    }
}
