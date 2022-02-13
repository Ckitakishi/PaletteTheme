//
//  GroupByYearItemList.swift
//
//  Used on Home view.
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Publish
import Plot

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
            return Wrapper {
                H2("\(year)")
                List(sortedArticles) { item in
                    Article {
                        Span("\(item.date.formattedString)    ")
                        Span(Link(item.title, url: item.path.absoluteString))
                    }
                }
                .class("group-item-list")
            }
        }
    }
}
