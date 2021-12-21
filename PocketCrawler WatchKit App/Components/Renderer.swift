//
//  Renderer.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 19/12/2021.
//

import SwiftUI

struct Renderer: View {
    @ObservedObject var state = PositionState()
    @State var crown = 0.0
    
    let ROTATION = 50.0
    
    var body: some View {
        ZStack {
            rooms
            map
        }
            .focusable()
            .digitalCrownRotation(
                $crown,
                from: 0,
                through: ROTATION,
                by: ROTATION,
                sensitivity: .medium,
                isContinuous: false
            )
    }
    
    private var map: some View {
        Map(plan: state.plan, position: state.position)
            .opacity(crown/ROTATION)
            .scaleEffect((1 - crown/ROTATION) + 1)
    }
    
    private var rooms: some View {
        RoomGrid(plan: state.plan, currentRoom: state.currentRoom) { direction in
            withAnimation(.easeOut) { state.move(direction) }
        }
            .opacity(1 - crown/ROTATION)
            .scaleEffect(1 - crown/ROTATION)
    }
}

struct Renderer_Previews: PreviewProvider {
    static var previews: some View {
        Renderer()
    }
}
