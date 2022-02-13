//
//  Sequence+Extensions.swift
//  
//
//  Created by Yuhan Chen on 2022/02/06.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        ascending: Bool = true
    ) -> [Element] {
        return sorted { lhs, rhs in
            if ascending {
                return lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
            }
            return lhs[keyPath: keyPath] > rhs[keyPath: keyPath]
        }
    }
}
