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
        level
    }
    
    private var level: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ForEach(plan.asRows(), id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { room in
                            item(for: room, with: geo)
                        }
                    }
                }
            }
        }
    }
    
    private func item(for room: RoomEntry?, with geo: GeometryProxy) -> GridItem {
        GridItem(
            width: geo.size.width / CGFloat(plan.columns),
            height: geo.size.height / CGFloat(plan.rows),
            room: room,
            current: room?.position == position
        )
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        PositionStateWrapper { state in
            Map(plan: state.plan, position: state.position)
        }
    }
}
