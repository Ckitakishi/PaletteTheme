//
//  Footer.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Foundation
import Plot

struct SiteFooter: Component {
    var body: Component {
        Footer {
            Paragraph {
                Text("Copyright © 2014-\(Calendar.current.component(.year, from: Date())) Ckitakishi")
                Text(" 🎨 ")
                Text("Powered by ")
                Link("Publish", url: "https://github.com/johnsundell/publish")
                    .class("link-underline")
                Text(" & ")
                Link("Palette", url: "https://github.com/Ckitakishi/PaletteTheme")
                    .class("link-underline")
            }
            .class("text-center")
        }
        .class("flex absolute justify-center mt-16 mb-4 text-zinc-500 text-sm font-light")
    }
}
