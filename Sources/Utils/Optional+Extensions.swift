//
//  Optional+Extensions.swift
//  
//
//  Created by Yuhan Chen on 2022/02/23.
//

extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}
