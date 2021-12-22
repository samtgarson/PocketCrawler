//
//  Renderer.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 19/12/2021.
//

import SwiftUI

struct GameRenderer: View {
    @ObservedObject var state = CoreState()
    @State var crown = 0.0
    
    let ROTATION = 50.0
    
    var body: some View {
        ZStack {
            if state.playState == .playing { game }
            if case .cutScene(let scene) = state.playState { cutScene(scene) }
        }
    }
    
    private func cutScene(_ scene: CutScene) -> some View {
        CutSceneRenderer(scene: scene)
            .transition(.opacity.animation(.easeOut.delay(0.3)))
    }
    
    private var game: some View {
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
            .transition(gameTransition)
    }
    
    private var map: some View {
        Map(plan: state.plan, position: state.position)
            .opacity(crown/ROTATION)
            .scaleEffect((1 - crown/ROTATION) + 1)
    }
    
    private var rooms: some View {
        RoomGrid(plan: state.plan, currentRoom: state.currentRoom, act: processAction)
            .opacity(1 - crown/ROTATION)
            .scaleEffect(1 - crown/ROTATION)
    }
    
    private func processAction(action: MapAction) {
        switch action {
        case .move(let direction):
            withAnimation { state.move(direction) }
        default:
            withAnimation { state.nextLevel() }
        }
    }
    
    var gameTransition: AnyTransition {
        let insertion = AnyTransition.opacity.combined(with: .scale(scale: 0.5)).animation(.easeOut(duration: 0.5).delay(1))
        let removal = AnyTransition.opacity.combined(with: .scale(scale: 1.5)).animation(.easeOut(duration: 0.5))
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct Renderer_Previews: PreviewProvider {
    static var previews: some View {
        GameRenderer(state: CoreState())
    }
}
