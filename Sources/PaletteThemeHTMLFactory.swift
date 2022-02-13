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
                Div {
                    Div {
                        SiteHeader(
                            context: context,
                            selectedItem: context.site.pages.first { $0.isIndex }
                        )
                        Wrapper {
                            H1(index.title)
                            
                            Div {
                                Paragraph(context.site.description)
                                SocialItemBar(context: context)
                                    .class("mt-4")
                            }
                            .class("my-16")
                            
                            H2("Latest Writing")
                                .class("my-4 font-bold")
                            ItemList(
                                items: Array(context.allItems(
                                    sortedBy: \.date,
                                    order: .descending
                                ).prefix(6)),
                                site: context.site
                            )
                            RoundButton(title: "Show more", url: "/posts")
                        }
                        SiteFooter()
                    }
                    .class("max-w-screen-md")
                }
                .class("flex justify-center mx-8")
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
                SiteHeader(context: context, selectedItem: currentPage)
                Wrapper {
                    switch currentPage.listType {
                    case .groupByYear:
                        GroupByYearItemList(items: section.items, site: context.site)
                    case .default:
                        ItemList(items: section.items, site: context.site)
                    }
                }
                .class("section-wrapper")
                SiteFooter()
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
                    SiteHeader(context: context, selectedItem: nil)
                    Wrapper {
                        Article {
                            Div(item.content.body).class("content")
                            Span("Tagged with: ")
                            ItemTagList(item: item, site: context.site)
                        }
                        .class("max-w-screen-md")
                        .class("prose prose-zinc")
                    }
                    .class("flex justify-center mx-8")
                    SiteFooter()
                }
            )
        )
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedItem: nil)
                Wrapper(page.body)
                SiteFooter()
            }
        )
    }

    func makeTagListHTML(for page: TagListPage,  context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedItem: nil)
                Wrapper {
                    H1("Browse all tags")
                    List(page.tags.sorted()) { tag in
                        ListItem {
                            Link(tag.string,
                                 url: context.site.path(for: tag).absoluteString
                            )
                        }
                        .class("tag")
                    }
                    .class("all-tags")
                }
                SiteFooter()
            }
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,  context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(
                    context: context,
                    selectedItem: context.site.pages.first { $0.title == page.tag.string }
                )
                Wrapper {
                    H1 {
                        Text("Tagged with ")
                        Span(page.tag.string).class("tag")
                    }

                    Link("Browse all tags",
                        url: context.site.tagListPath.absoluteString
                    )
                    .class("browse-all")

                    ItemList(
                        items: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        site: context.site
                    )
                }
                SiteFooter()
            }
        )
    }
}
