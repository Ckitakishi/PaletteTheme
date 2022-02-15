//
//  Wrapper.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Plot

struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div(content: content).class("wrapper")
    }
}

struct CenterMDContainer: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div {
            Div(content: content)
                .class("max-w-screen-md w-full m-4")
                .class("flex flex-col") // To make the footer stick to bottom.
            
        }
        .class("flex justify-center min-h-full")
    }
}
