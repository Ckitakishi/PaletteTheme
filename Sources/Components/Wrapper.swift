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
