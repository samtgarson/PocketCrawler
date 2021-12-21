//
//  GameState.swift
//  PocketCrawlerTests
//
//  Created by Sam Garson on 18/12/2021.
//

import XCTest
@testable import PocketCrawler_WatchKit_Extension

class PositionStateTests: XCTestCase {
    var state = PositionState()
    
    func testInit() {
        XCTAssertEqual(state.position, state.plan.center)
    }
}
