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
class FloorplanGenerator<R : RandomNumberGenerator> {
    
    init(size: PlanSize = .Small, rng: R) {
        self.rng = rng
        let (num, min, max) = FloorplanGenerator.getMeta(size)
        self.minRooms = min
        self.maxRooms = max
        self.plan = .init(rows: num, columns: num)
    }
    
    func generate() -> Floorplan {
        iterate()
        return plan
    }
    
    var endRooms = [Coordinate]()
    private let plan: Floorplan
    private var rng: R
    private var queue = [Coordinate]()
    private var roomCount = 0
    private let maxRooms: Int
    private let minRooms: Int
    private let MAX_ITERATIONS = 500
    
    private func iterate(_ iteration: Int = 0) {
        precondition(iteration <= MAX_ITERATIONS, "Failed to generate plan in \(iteration) attempts")
        _ = visit(plan.center)
        
        while queue.count > 0 {
            processLocation(queue.removeFirst())
        }
        
        if roomCount < minRooms {
            plan.reset()
            self.queue = [Coordinate]()
            self.endRooms = [Coordinate]()
            iterate(iteration + 1)
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
        guard plan.validLocation(loc) else { return false }
        guard !plan.exists(loc) else { return false }
        guard plan.neighbours(of: loc).count <= 1 else { return false }
        guard roomCount < maxRooms else { return false }
        
        if loc != plan.center && Bool.random(using: &rng) { return false }
        
        queue.append(loc)
        plan[loc] = room(for: loc)
        roomCount += 1

        return true
    }
    
    private func room(for location: Coordinate) -> RoomEntry {
        RoomEntry(position: location, plan: plan)
    }
    
    private func assignSpecialRooms() {
        if let bossLoc = endRooms.popLast(),
           let bossRoom = plan[bossLoc] { bossRoom.type = .boss }
        
        if let itemLoc = endRooms.popRandom(using: &rng),
           let itemRoom = plan[itemLoc] { itemRoom.type = .item }
        
        if let shopLoc = endRooms.popRandom(using: &rng),
           let shopRoom = plan[shopLoc] { shopRoom.type = .shop }
    }
    
    #if DEBUG
    func debugPrint() {
        print("  " + (0..<plan.columns).map({ "\($0)" }).joined(separator: " "))
        
        for (y, row) in plan.asRows().enumerated() {
            let rowStr = row.map { $0?.debugLabel ?? "∙" }
            
            print("\(y) \(rowStr.joined(separator: " "))")
        }
    }
    #endif
    
    private static func getMeta(_ size: PlanSize) -> (Int, Int, Int) {
        switch size {
        case .Small:
            return (4, 6, 10)
        case .Medium:
            return (5, 9, 15)
        case .Large:
            return (7, 12, 18)
        }
    }
}

extension FloorplanGenerator where R == SystemRandomNumberGenerator {
    convenience init(size: PlanSize = .Small) {
        self.init(size: size, rng: SystemRandomNumberGenerator())
    }
}

typealias DefaultFloorplanGenerator = FloorplanGenerator<SystemRandomNumberGenerator>
