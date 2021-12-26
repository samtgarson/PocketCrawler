//
//  Level.swift
//  Level
//
//  Created by Sam Garson on 01/08/2021.
//

import SwiftUI

struct Map: View {
    var plan: Floorplan
    var position: Coordinate
    
    var body: some View {
        TabView {
            level.tabItem { Text("Map") }
            InGameMenu().tabItem { Text("Menu") }
        }
    }
    
    private var level: some View {
        GeometryReader { geo in
            Group {
                ForEach(plan.allRooms, id: \.id) { room in
                    item(for: room, with: geo)
                }
            }
        }
    }
    
    private func item(for room: RoomEntry, with geo: GeometryProxy) -> some View {
        let width = geo.size.width / CGFloat(plan.columns)
        let height = geo.size.height / CGFloat(plan.rows)
        
        return GridItem(
            width: width,
            height: height,
            room: room,
            current: room.position == position
        ).offset(x: width * CGFloat(room.position.x), y: height * CGFloat(room.position.y))
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper { state in
            Map(plan: state.plan, position: state.position)
        }
    }
}
