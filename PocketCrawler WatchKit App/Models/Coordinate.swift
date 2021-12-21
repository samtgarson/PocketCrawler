//
//  Coordinate.swift
//  Coordinate
//
//  Created by Sam Garson on 31/07/2021.
//

import Foundation
import CoreGraphics

enum Direction: CaseIterable {
    case up, down, left, right
}

enum Axis {
    case horizontal, vertical
}

class Coordinate {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    var neighbours: [Coordinate] {
        Direction.allCases.map { neighbour($0) }
    }
    
    var size: CGSize {
        CGSize(width: x, height: y)
    }
    
    func neighbour(_ direction: Direction) -> Coordinate {
        switch direction {
        case .up:
            return Coordinate(x, y - 1)
        case .down:
            return Coordinate(x, y + 1)
        case .left:
            return Coordinate(x - 1, y)
        case .right:
            return Coordinate(x + 1, y)
        }
    }
}

extension Coordinate : Equatable {
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}
