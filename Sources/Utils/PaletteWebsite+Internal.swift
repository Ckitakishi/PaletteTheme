//
//  PaletteCustomizable+Internal.swift
//  
//
//  Created by Yuhan Chen on 2022/02/26.
//

import Plot

extension PaletteCustomizable {
    var headCustomNodes: [Node<HTML.HeadContext>] {
        var nodes: [Node<HTML.HeadContext>] = []
        if let googleTrackingCode = googleTrackingCode {
            nodes.append(.raw(googleTrackingCode))
        }
        return nodes
    }
    
    var googleTrackingCode: String? {
        guard let trackingID = googleTrackingID else { return nil }
        
        return """
        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=\(trackingID)"></script>
        <script>
          window.dataLayer = window.dataLayer || [];
          function gtag(){dataLayer.push(arguments);}
          gtag('js', new Date());
          gtag('config', '\(trackingID)');
        </script>
        """
    }
}
