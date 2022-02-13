//
//  PaletteThemeTests.swift
//  
//
//  Created by Yuhan Chen on 2022/02/12.
//

import XCTest
@testable import PaletteTheme

class PaletteThemeTests: XCTestCase {
    private struct SampleArticle {
        let title: String
        let date: Date
    }
    
    func testSortedByKeyPath() throws {
        let articles = [
            SampleArticle(title: "1", date: Date.distantPast),
            SampleArticle(title: "2", date: Date())
        ]
        XCTAssertEqual(articles.sorted(by: \.date).map(\.title), ["1", "2"])
        XCTAssertEqual(articles.sorted(by: \.date, ascending: false).map(\.title), ["2", "1"])
    }
}
