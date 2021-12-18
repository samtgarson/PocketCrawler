//
//  Level.swift
//  Level
//
//  Created by Sam Garson on 01/08/2021.
//

import SwiftUI

struct Level: View {
    @ObservedObject var state: GameState
    
    var body: some View {
        level
    }
    
    private var level: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ForEach(state.plan.asRows(), id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { room in
                            item(for: room, with: geo)
                        }
                    }
                }
            }
        }
    }
    
    private func item(for room: Room?, with geo: GeometryProxy) -> GridItem {
        GridItem(
            width: geo.size.width / CGFloat(state.plan.columns),
            height: geo.size.height / CGFloat(state.plan.rows),
            room: room,
            current: room?.position == state.position
        )
    }
}

struct Level_Previews: PreviewProvider {
    static var previews: some View {
        Level(state: GameState(level: .Four))
    }
}
