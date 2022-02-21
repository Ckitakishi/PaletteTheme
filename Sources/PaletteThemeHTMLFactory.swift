//
//  PaletteThemeHTMLFactory.swift
//  
//
//  Created by Yuhan Chen on 2022/01/23.
//

import Publish
import Plot

struct PaletteThemeHTMLFactory<Site: PaletteWebsite>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body {
                PageContainer {
                    RibbonView()
                    CenterContainer {
                        SiteHeader(
                            context: context,
                            selectedItem: context.site.pages.first { $0.isIndex }
                        )
                        Div {
                            // Profile
                            Div {
                                H2("About")
                                    .class("top-h2")
                                Article {
                                    Div(Markdown(context.site.description)).class("content")
                                }
                                .class("prose prose-zinc min-w-full")
                                .class("dark:prose-invert")
                                SocialItemBar(context: context)
                                    .class("mt-4")
                            }
                            .class("mb-16")
                            
                            // Latest Writing
                            H2("Latest Writing").class("top-h2")
                            ItemList(
                                items: Array(context.allItems(
                                    sortedBy: \.date,
                                    order: .descending
                                ).prefix(6)),
                                site: context.site
                            )
                            Div {
                                UnderlineButton(title: "Show more", url: "/posts")
                                    .class("float-right")
                            }
                            .class("overflow-hidden")
                        }
                    }
                    SiteFooter(context: context)
                }
            }
        )
    }

    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        guard let currentPage = context.site.pages.first(
            where: { $0.id == section.id.rawValue }
        ) else {
            return HTML()
        }
        
        return HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body {
                PageContainer {
                    RibbonView()
                    CenterContainer {
                        SiteHeader(context: context, selectedItem: currentPage)
                        Div {
                            switch currentPage.listType {
                            case .groupByYear:
                                GroupByYearItemList(items: section.items, site: context.site)
                            case .default:
                                ItemList(items: section.items, site: context.site)
                            }
                        }
                    }
                    SiteFooter(context: context)
                }
            }
        )
    }

    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .components {
                    PageContainer {
                        RibbonView()
                        FlatHeader(context: context, selectedItem: nil)
                        CenterContainer {
                            ItemTagListWithDate(item: item, site: context.site)
                                .class("mb-1")
                            Article {
                                Div(item.content.body).class("content")
                            }
                            .class("prose prose-zinc min-w-full")
                            .class("dark:prose-invert")
                        }
                        .class("mx-4")
                        SiteFooter(context: context)
                    }
                }
            )
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                PageContainer {
                    RibbonView()
                    FlatHeader(context: context, selectedItem: nil)
                    CenterContainer {
                        Div(page.body)
                    }
                    .class("mx-4")
                    SiteFooter(context: context)
                }
            }
        )
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                PageContainer {
                    RibbonView()
                    CenterContainer {
                        SiteHeader(context: context, selectedItem: nil)
                        Div {
                            List(page.tags.sorted()) { tag in
                                ListItem {
                                    Link(tag.string, url: context.site.path(for: tag).absoluteString)
                                        .class("hashtag link-underline")
                                }
                            }
                            .class("flex flex-wrap gap-4")
                        }
                    }
                    SiteFooter(context: context)
                }
            }
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,  context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                PageContainer {
                    RibbonView()
                    CenterContainer {
                        SiteHeader(
                            context: context,
                            selectedItem: context.site.pages.first { $0.title == page.tag.string }
                        )
                        Div {
                            H2 {
                                Text("Tagged with ")
                                Span(page.tag.string).class("hashtag")
                            }
                            .class("top-h2")

                            ItemList(
                                items: context.items(
                                    taggedWith: page.tag,
                                    sortedBy: \.date,
                                    order: .descending
                                ),
                                site: context.site
                            )
                            
                            Div {
                                UnderlineButton(
                                    title: "Browse all tags",
                                    url: context.site.tagListPath.absoluteString
                                ).class("float-right")
                            }
                            .class("overflow-hidden")
                        }
                    }
                    SiteFooter(context: context)
                }
            }
        )
    }
}
