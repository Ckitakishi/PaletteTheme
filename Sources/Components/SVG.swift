//
//  ClickableSVG.swift
//
//
//  Created by Yuhan Chen on 2022/02/13.
//

import Plot

/// Component used to render a SVG image using an `<svg>` element.
public struct SVG: Component {
    /// The svg path
    public let path: String
    /// The value of view box
    public let viewBox: String

    /// Create a new SVG instance.
    /// - parameters:
    ///   - path: The SVG image's path.
    public init(path: String, viewBox: String) {
        self.path = path
        self.viewBox = viewBox
    }

    public var body: Component {
        Node.svg(
            .element(named: "svg", nodes: [
                .attribute(named: "xmlns", value: "http://www.w3.org/2000/svg"),
                .attribute(named: "viewBox", value: viewBox),
                // <!--! Font Awesome Pro 6.0.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2022 Fonticons, Inc. -->
                .element(
                    named: "path",
                    attributes: [.attribute(named: "d", value: path)]
                )
            ])
        )
    }
}

public extension Node where Context: HTML.BodyContext {
    static func svg(_ nodes: Node<HTML.Context>...) -> Node {
        .element(named: "svg", nodes: nodes)
    }
}
