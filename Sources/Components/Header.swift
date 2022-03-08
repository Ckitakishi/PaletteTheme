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
        let profilePath = context.site.profileIconPath
        
        return Header {
            Div {
                if let profilePath = profilePath {
                    Image(url: profilePath, description: "Profile icon")
                        .class("w-[60px] h-[60px] rounded-full")
                }
                Div {
                    Link(context.site.name, url: "/")
                        .class("header-title font-extrabold text-4xl")
                    NavigationBar(context: context, selectedItem: selectedItem)
                }
            }
            .class("my-16")
            .class(profilePath == nil ? "" : "flex flex-col items-center gap-2 ssm:flex-row")
        }
        .class("text-zinc-900 dark:text-zinc-50")
    }
}

struct FlatHeader<Site: PaletteWebsite>: Component {
    var context: PublishingContext<Site>
    var selectedItem: PalettePage?

    var body: Component {
        Header {
            Div {
                Link(context.site.name, url: "/")
                    .class("header-title font-extrabold text-3xl")
                NavigationBar(context: context, selectedItem: selectedItem)
                    .class("my-auto")
            }
            .class("flex flex-wrap justify-between my-4 gap-x-16 max-w-screen-lg w-full")
        }
        .class("flex justify-center p-4")
        .class("text-zinc-900 dark:text-zinc-50")
    }
}

private struct NavigationBar<Site: PaletteWebsite>: Component {
    var context: PublishingContext<Site>
    var selectedItem: PalettePage?

    var body: Component {
        Navigation {
            List(context.site.pages) { navigationItem in
                Link(navigationItem.title, url: navigationItem.link)
                    .class(navigationItem == selectedItem ? "selected" : "")
                    .class("hover:underline underline-offset-4")
            }
            .class("flex flex-wrap gap-4")
        }
    }
}
