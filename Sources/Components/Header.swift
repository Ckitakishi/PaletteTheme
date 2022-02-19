//
//  Header.swift
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
            Div {
                Link(context.site.name, url: "/")
                    .class("font-extrabold text-4xl")
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

struct FlatHeader<Site: PaletteWebsite>: Component {
    var context: PublishingContext<Site>
    var selectedItem: PalettePage?

    var body: Component {
        Header {
            Div {
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
                .class("my-auto")
            }
            .class("flex flex-wrap justify-between my-4 gap-x-16 max-w-screen-lg w-full")
        }
        .class("flex justify-center m-4")
    }
}
