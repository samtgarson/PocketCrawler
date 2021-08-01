//
//  PocketCrawlerTests.swift
//  PocketCrawlerTests
//
//  Created by Sam Garson on 30/07/2021.
//

import XCTest
@testable import PocketCrawler_WatchKit_Extension

class FloorplanTests: XCTestCase {
    let plan = Floorplan(rng: MockRandomNumberGenerator())
    
    func testGenerate() throws {
        let expected = [
            [false, false, false, false, false, false, false],
            [false, false, false, true,  false, false, false],
            [false, true,  false, true,  false, true,  false],
            [true,  true,  true,  true,  true,  true,  true ],
            [false, true,  false, true,  false, true,  false],
            [false, false, false, true,  false, false, false],
            [false, false, false, false, false, false, false]
        ]
        
        for (y, row) in plan.enumerated() {
            for (x, room) in row.enumerated() {
                if expected[y][x] {
                    XCTAssertNotNil(room)
                } else {
                    XCTAssertNil(room)
                }
            }
        }
    }
    
    func testEndRooms() throws {
        let expected = [[1, 3], [5, 3], [3, 0], [2, 1], [4, 1], [3, 6], [2, 5], [4, 5]]
        let result = plan.endRooms.map { [$0.x, $0.y] }
        XCTAssertEqual(expected, result)
    }
    
    class MockRandomNumberGenerator : RandomNumberGenerator {
        func next() -> UInt64 {
            return UInt64.max
        }
    }
}
