//
//  Room.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 18/12/2021.
//

import SwiftUI

struct Room: View {
    var room: RoomEntry
    var act: (MapAction) -> Void = {_ in }
    
    var body: some View {
        VStack(spacing: 4) {
            wall(.up)
            HStack(spacing: 4) {
                wall(.left)
                contents
                wall(.right)
            }
            wall(.down)
        }
    }
    
    private func wall(_ dir: Direction) -> some View {
        Wall(dir: dir, canMove: room.canMove(in: dir)) {
            act(.move(dir))
        }
    }
    
    var contents: some View {
        Group {
            switch room.type {
            case .boss:
                BossRoom { act(.nextFloor) }
            case .shop:
                RoundedRectangle(cornerRadius: 15)
            case .item:
                RoundedRectangle(cornerRadius: 15)
            case .normal:
                RoundedRectangle(cornerRadius: 15)
            }
        }
    }
}

struct BaseRoom_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper { state in
            Room(room: state.currentRoom)
        }
    }
}
