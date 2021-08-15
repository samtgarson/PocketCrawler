//
//  Room.swift
//  Room
//
//  Created by Sam Garson on 01/08/2021.
//

import Foundation

class Room : Identifiable {
    let id = UUID()
    let position: Coordinate
    
    init(position: Coordinate) {
        self.position = position
    }
    
    enum RoomType {
        case boss, shop, item, normal
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

extension Room : Hashable {
    static func == (lhs: Room, rhs: Room) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
