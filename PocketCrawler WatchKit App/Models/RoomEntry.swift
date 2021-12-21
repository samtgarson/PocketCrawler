//
//  Room.swift
//  Room
//
//  Created by Sam Garson on 01/08/2021.
//

import Foundation

class RoomEntry : Identifiable {
    let id = UUID()
    let position: Coordinate
    let plan: Floorplan
    
    init(position: Coordinate, plan: Floorplan) {
        self.position = position
        self.plan = plan
    }
    
    enum RoomType {
        case boss, shop, item, normal
    }
    
    func canMove(in direction: Direction) -> Bool {
        let loc = position.neighbour(direction)
        return plan.validLocation(loc) && plan.exists(loc)
    }
    
    var type: RoomType = .normal
    
    #if DEBUG
    var debugLabel: String {
        switch type {
        case .boss:
            return "B"
        case .shop:
            return "S"
        case .item:
            return "I"
        case .normal:
            return "■"
        }
    }
    #endif
}

extension RoomEntry : Hashable {
    static func == (lhs: RoomEntry, rhs: RoomEntry) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
