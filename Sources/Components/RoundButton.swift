//
//  RoundButton.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Plot

struct RoundButton: Component {
    var title: String
    var url: String
    
    var body: Component {
        Div {
            Link(title, url: url)
        }
        .class("round-btn-container")
    }
}
