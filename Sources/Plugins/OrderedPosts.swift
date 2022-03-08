//
//  OrderedPosts.swift
//  
//
//  Created by Yuhan Chen on 2022/03/02.
//

import Publish
import Plot

private var sortedItemMetadata: [OrderedItemMetaData] = []
private var contentCount: Int = sortedItemMetadata.count

public struct OrderedItemMetaData {
    let title: String
    let pathString: String
}

public extension Plugin {
    static func orderedPosts() -> Self {
        Plugin(name: "OrderedPosts") { context in
            sortedItemMetadata = context
                .allItems(sortedBy: \.date)
                .map { .init(title: $0.title, pathString: $0.path.absoluteString) }
        }
    }
}

extension Item {
    var indexInAllItems: Int? {
        sortedItemMetadata.firstIndex(where: { $0.pathString == self.path.absoluteString })
    }
    
    var previous: OrderedItemMetaData? {
        guard let index = indexInAllItems, index > 0 else { return nil }
        return sortedItemMetadata[index - 1]
    }
    
    var next: OrderedItemMetaData? {
        guard let index = indexInAllItems, index < contentCount - 1 else { return nil }
        return sortedItemMetadata[index + 1]
    }
}
