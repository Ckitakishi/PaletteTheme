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
                Text(" & ")
                Link("Palette", url: "https://github.com/Ckitakishi/PaletteTheme")
            }
        }
    }
}
