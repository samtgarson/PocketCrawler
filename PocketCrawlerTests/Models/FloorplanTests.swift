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
    
    func testDebugPrint() {
        plan.debugPrint()
    }
    
    func testGenerate() throws {
        let expected = [
            [false, true , true,  true , false],
            [true , false, true,  false, false],
            [true , true , true,  true , true ],
            [true , false, true,  false, false],
            [false, true , true,  true , false]
        ]
        
        for (y, row) in plan.asRows().enumerated() {
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
        let expected = [[4, 2], [1, 0], [3, 0], [1, 4]]
        let result = plan.endRooms.map { [$0.x, $0.y] }
        XCTAssertEqual(expected, result)
    }
    
    func testSpecialRooms() throws {
        XCTAssertEqual(.boss, plan[0, 3]?.type)
        XCTAssertEqual(.item, plan[0, 1]?.type)
        XCTAssertEqual(.shop, plan[3, 4]?.type)
    }
    
    class MockRandomNumberGenerator : RandomNumberGenerator {
        func next() -> UInt64 {
            return UInt64.max
        }
    }
}
