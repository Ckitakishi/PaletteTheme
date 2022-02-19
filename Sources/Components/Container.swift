//
//  Container.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Plot

struct CenterContainer: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div {
            Div(content: content)
                .class("max-w-screen-md w-full m-4")
                .class("flex flex-col") // To make the footer stick to bottom.
            
        }
        .class("flex justify-center min-h-full")
        .class("text-zinc-900 dark:text-zinc-50")
    }
}
