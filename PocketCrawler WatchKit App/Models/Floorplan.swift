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
    init(size: Int = 7, max: Int = 15, rng: R) {
        self.rng = rng
        self.minRooms = size
        self.maxRooms = max
        super.init(rows: size, columns: size)
        generate()
    }
    
    var endRooms = [Coordinate]()
    private var rng: R
    private var queue = [Coordinate]()
    private var roomCount = 0
    private let maxRooms: Int
    private let minRooms: Int
    private let MAX_ITERATIONS = 1000
    
    private func generate(_ iteration: Int = 0) {
        precondition(iteration <= MAX_ITERATIONS, "Failed to generate plan in time")
        _ = visit(center)
        
        while queue.count > 0 {
            processLocation(queue.removeFirst())
        }
        
        if roomCount < minRooms { generate(iteration + 1) }
        
        assignSpecialRooms()
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
        guard roomCount < maxRooms else { return false }
        
        if loc != center && Bool.random(using: &rng) { return false }
        
        queue.append(loc)
        self[loc] = Room()
        roomCount += 1

        return true
    }
    
    private func assignSpecialRooms() {
        if let bossLoc = endRooms.popLast(),
           let bossRoom = self[bossLoc] { bossRoom.type = .boss }
        
        if let itemLoc = endRooms.popRandom(using: &rng),
           let itemRoom = self[itemLoc] { itemRoom.type = .item }
        
        if let shopLoc = endRooms.popRandom(using: &rng),
           let shopRoom = self[shopLoc] { shopRoom.type = .shop }
    }
    
    #if DEBUG
    func debugPrint() {
        for (y, row) in self.enumerated() {
            if y == 0 {
                print("  0 1 2 3 4")
            }
            let row: [String] = row.map { room in
                room?.debugLabel ?? "∙"
            }
            print("\(y) \(row.joined(separator: " "))")
        }
    }
    #endif
}

extension Floorplan where R == SystemRandomNumberGenerator {
    convenience init() {
        self.init(rng: SystemRandomNumberGenerator())
    }
}
