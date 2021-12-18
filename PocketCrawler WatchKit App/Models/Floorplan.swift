//
//  Floorplan.swift
//  Floorplan
//
//  Created by Sam Garson on 30/07/2021.
//

import Foundation
import CoreLocation

enum PlanSize { case Small, Medium, Large }

/// https://www.boristhebrave.com/2020/09/12/dungeon-generation-in-binding-of-isaac/
class Floorplan<R : RandomNumberGenerator>: Matrix<Room> {
    
    init(size: PlanSize = .Small, rng: R) {
        self.rng = rng
        let (num, min, max) = Floorplan.getMeta(size)
        self.minRooms = min
        self.maxRooms = max
        super.init(rows: num, columns: num)
        generate()
    }
    
    var endRooms = [Coordinate]()
    private var rng: R
    private var queue = [Coordinate]()
    private var roomCount = 0
    private let maxRooms: Int
    private let minRooms: Int
    private let MAX_ITERATIONS = 500
    
    private func generate(_ iteration: Int = 0) {
        precondition(iteration <= MAX_ITERATIONS, "Failed to generate plan in \(iteration) attempts")
        _ = visit(center)
        
        while queue.count > 0 {
            processLocation(queue.removeFirst())
        }
        
        if roomCount < minRooms {
            reset()
            self.queue = [Coordinate]()
            self.endRooms = [Coordinate]()
            generate(iteration + 1)
        }
        
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
        self[loc] = Room(position: loc)
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
        print("  " + (0..<columns).map({ "\($0)" }).joined(separator: " "))
        
        for (y, row) in asRows().enumerated() {
            let rowStr = row.map { $0?.debugLabel ?? "∙" }
            
            print("\(y) \(rowStr.joined(separator: " "))")
        }
    }
    #endif
    
    private static func getMeta(_ size: PlanSize) -> (Int, Int, Int) {
        switch(size) {
        case .Small:
            return (4, 6, 10)
        case .Medium:
            return (5, 9, 15)
        case .Large:
            return (7, 12, 18)
        }
    }
}

extension Floorplan where R == SystemRandomNumberGenerator {
    convenience init(size: PlanSize = .Small) {
        self.init(size: size, rng: SystemRandomNumberGenerator())
    }
}

typealias DefaultFloorplan = Floorplan<SystemRandomNumberGenerator>
