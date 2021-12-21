//
//  Room.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 18/12/2021.
//

import SwiftUI

struct Room: View {
    var room: RoomEntry
    var onMove: (Direction) -> Void = {_ in }
    
    var body: some View {
        VStack {
            wall(.up)
            HStack {
                wall(.left)
                RoundedRectangle(cornerRadius: 15)
                wall(.right)
            }
            wall(.down)
        }
    }
    
    private func wall(_ dir: Direction) -> some View {
        Wall(dir: dir, canMove: room.canMove(in: dir)) {
            onMove(dir)
        }
    }
}

struct BaseRoom_Previews: PreviewProvider {
    static var previews: some View {
        BaseRoomPreview()
    }
    
    struct BaseRoomPreview: View {
        @ObservedObject var state = PositionState()
        
        var body: some View {
            Room(room: state.currentRoom) { dir in
                state.move(dir)
            }
        }
    }
}
