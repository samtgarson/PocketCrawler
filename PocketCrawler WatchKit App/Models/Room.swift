//
//  Room.swift
//  Room
//
//  Created by Sam Garson on 01/08/2021.
//

import Foundation

class Room {
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
