//
//  RoomGrid.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 20/12/2021.
//

import SwiftUI

struct RoomGrid: View {
    var plan: Floorplan
    var currentRoom: RoomEntry
    var move: (Direction) -> Void
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(plan.allRooms) { r in
                    Room(room: r, onMove: move) 
                    .opacity(r == currentRoom ? 1 : 0)
                    .offset(roomOffset(for: r, in: geo.size))
                }
            }.offset(gridOffset(in: geo.size))
        }
    }
    
    private func roomOffset(for room: RoomEntry, in view: CGSize) -> CGSize {
        let size = room.position.size
        
        return CGSize(
            width: size.width * view.width,
            height: size.height * view.height
        )
    }
    
    private func gridOffset(in view: CGSize) -> CGSize {
        let size = currentRoom.position.size
        
        return CGSize(
            width: size.width * view.width * -1,
            height: size.height * view.height * -1
        )
    }
}

struct RoomGrid_Previews: PreviewProvider {
    static var previews: some View {
        PositionStateWrapper { state in        
            RoomGrid(plan: state.plan, currentRoom: state.currentRoom, move: state.move)
        }
    }
}
