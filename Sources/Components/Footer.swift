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
            }
            .class("text-center mt-16")
            Paragraph {
                Text("Powered by ")
                Link("Publish", url: "https://github.com/johnsundell/publish")
                    .class("link-underline")
                Text(" & ")
                Link("Palette", url: "https://github.com/Ckitakishi/PaletteTheme")
                    .class("link-underline")
            }
            .class("text-center mt-1")
        }
        .class("flex flex-col mb-4 text-sm font-light")
        .class("mt-auto") // To make the footer stick to bottom.
        .class("text-zinc-500 dark:text-zinc-400")
    }
}
