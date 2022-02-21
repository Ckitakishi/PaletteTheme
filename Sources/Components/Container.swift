//
//  Container.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Plot
import Publish

struct PageContainer: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div(content: content)
            .class("flex flex-col min-h-full") // To make the footer stick to bottom.
            .class("text-zinc-900 dark:text-zinc-50")
    }
}

struct CenterContainer: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div {
            Div(content: content)
                .class("max-w-screen-md w-full m-4")
        }
        .class("flex justify-center")
    }
}
