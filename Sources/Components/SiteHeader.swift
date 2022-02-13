//
//  SiteHeader.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Publish
import Plot

struct SiteHeader<Site: PaletteWebsite>: Component {
    var context: PublishingContext<Site>
    var selectedItem: PalettePage?

    var body: Component {
        Header {
            Wrapper {
                Link(context.site.name, url: "/")
                    .class("font-extrabold text-3xl")
                Navigation {
                    List(context.site.pages) { navigationItem in
                        Link(navigationItem.title, url: navigationItem.link)
                            .class(navigationItem == selectedItem ? "selected" : "")
                            .class("hover:underline underline-offset-4")
                    }
                    .class("flex flex-wrap gap-4")
                }
            }
            .class("my-16")
        }
    }
}
