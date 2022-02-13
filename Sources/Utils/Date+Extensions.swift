//
//  Date+Extensions.swift
//  
//
//  Created by Yuhan Chen on 2022/02/07.
//

import Foundation

extension Date {
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var formattedString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
