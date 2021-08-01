//
//  PocketCrawlerTests.swift
//  PocketCrawlerTests
//
//  Created by Sam Garson on 30/07/2021.
//

import XCTest
@testable import PocketCrawler_WatchKit_Extension

class MatrixTests: XCTestCase {
    
    var matrix = Matrix<String>(rows: 5, columns: 5)
    
    func testSubscript() throws {
        matrix[2, 2] = "×"
        XCTAssertEqual(matrix[2, 2], "×")
        XCTAssertNil(matrix[1, 2])
    }
    
    func testvalidLocation() throws {
        XCTAssertFalse(matrix.validLocation(row: 0, column: -1))
        XCTAssertFalse(matrix.validLocation(row: -1, column: 0))
        XCTAssertFalse(matrix.validLocation(row: 0, column: 5))
        XCTAssertFalse(matrix.validLocation(row: 10, column: 2))
        XCTAssertTrue(matrix.validLocation(row: 2, column: 2))
    }
    
    func testCenter() throws {
        XCTAssertEqual(matrix.center, Coordinate(2, 2))
    }
}
