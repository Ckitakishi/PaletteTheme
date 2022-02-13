//
//  UnderlineButton.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Plot

struct UnderlineButton: Component {
    let title: String
    let url: String
    
    var body: Component {
        Link(title, url: url).class("font-medium text-lg underline underline-offset-4")
    }
}
