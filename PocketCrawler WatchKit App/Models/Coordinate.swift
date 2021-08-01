//
//  Coordinate.swift
//  Coordinate
//
//  Created by Sam Garson on 31/07/2021.
//

import Foundation

class Coordinate {
    let x: Int
    let y: Int
    
    static var cardinals: [KeyPath<Coordinate, Coordinate>] {
        [\.up, \.down, \.left, \.right]
    }
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    var up: Coordinate {
        return Coordinate(x, y - 1)
    }
    
    var down: Coordinate {
        return Coordinate(x, y + 1)
    }
    
    var left: Coordinate {
        return Coordinate(x - 1, y)
    }
    
    var right: Coordinate {
        return Coordinate(x + 1, y)
    }
    
    var neighbours: [Coordinate] {
        Coordinate.cardinals.map { self[keyPath: $0] }
    }
}

extension Coordinate : Equatable {
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}
