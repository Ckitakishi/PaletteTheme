//
//  Plugin+OrderedPosts.swift
//
//
//  Created by Yuhan Chen on 2022/03/02.
//

import Publish
import Plot
import os

final class ItemMetadataStorage: Sendable {
    private let sortedItemMetadataLock = OSAllocatedUnfairLock<[OrderedItemMetaData]>(uncheckedState: [])
    fileprivate var sortedItemMetadata: [OrderedItemMetaData] {
        get { sortedItemMetadataLock.withLock { $0 } }
        set { sortedItemMetadataLock.withLock { $0 = newValue } }
    }
    
    fileprivate var contentCount: Int {
        sortedItemMetadataLock.withLock { $0.count }
    }
}

private let storage = ItemMetadataStorage()

public struct OrderedItemMetaData : Sendable {
    let title: String
    let pathString: String
}

extension Plugin {
    public static func orderedPosts() -> Self {
        Plugin(name: "OrderedPosts") { context in
            storage.sortedItemMetadata = context
                .allItems(sortedBy: \.date)
                .map { .init(title: $0.title, pathString: $0.path.absoluteString) }
        }
    }
}

extension Item {
    var indexInAllItems: Int? {
        storage.sortedItemMetadata.firstIndex(where: { $0.pathString == self.path.absoluteString })
    }
    
    var previous: OrderedItemMetaData? {
        guard let index = indexInAllItems, index > 0 else { return nil }
        return storage.sortedItemMetadata[index - 1]
    }
    
    var next: OrderedItemMetaData? {
        guard let index = indexInAllItems, index < storage.contentCount - 1 else { return nil }
        return storage.sortedItemMetadata[index + 1]
    }
}
