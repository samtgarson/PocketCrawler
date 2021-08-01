//
//  Floorplan.swift
//  Floorplan
//
//  Created by Sam Garson on 30/07/2021.
//

import Foundation
import CoreLocation


/// https://www.boristhebrave.com/2020/09/12/dungeon-generation-in-binding-of-isaac/
class Floorplan<R : RandomNumberGenerator>: Matrix<Room> {
    init(size: Int = 7, rng: R) {
        self.rng = rng
        super.init(rows: size, columns: size)
        generate()
    }
    
    var endRooms = [Coordinate]()
    private var rng: R
    private var queue = [Coordinate]()
    private var roomCount = 0
    private let MAX_ROOMS = 15
    private let MIN_ROOMS = 7
    private let MAX_ITERATIONS = 1000
    
    private func generate(_ iteration: Int = 0) {
        precondition(iteration <= MAX_ITERATIONS, "Failed to generate plan in time")
        _ = visit(center)
        
        while queue.count > 0 {
            processLocation(queue.removeFirst())
        }
        
        if roomCount < MIN_ROOMS { generate(iteration + 1) }
    }
    
    private func processLocation(_ loc: Coordinate) {
        var created = false
        for neighbour in loc.neighbours {
            let success = visit(neighbour)
            if success { created = success }
        }
        
        if !created { endRooms.append(loc) }
    }
    
    private func visit(_ loc: Coordinate) -> Bool {
        guard validLocation(loc) else { return false }
        guard self[loc] == nil else { return false }
        guard neighbours(of: loc).count <= 1 else { return false }
        guard roomCount < MAX_ROOMS else { return false }
        
        if loc != center && Bool.random(using: &rng) { return false }
        
        queue.append(loc)
        self[loc] = Room()
        roomCount += 1

        return true
    }
}

extension Floorplan where R == SystemRandomNumberGenerator {
    convenience init() {
        self.init(rng: SystemRandomNumberGenerator())
    }
}
