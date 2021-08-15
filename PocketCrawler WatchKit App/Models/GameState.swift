//
//  GameState.swift
//  GameState
//
//  Created by Sam Garson on 15/08/2021.
//

import Foundation

class GameState : ObservableObject {
    @Published var level: Int = 0
    @Published var position: Coordinate
    @Published var plan: DefaultFloorplan
    
    init() {
        let plan = Floorplan()
        self.plan = plan
        position = plan.center
    }
}
