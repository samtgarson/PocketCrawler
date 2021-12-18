//
//  GameState.swift
//  GameState
//
//  Created by Sam Garson on 15/08/2021.
//

import Foundation

class GameState : ObservableObject {
    @Published var level: LevelNumber
    @Published var position: Coordinate!
    @Published var plan: DefaultFloorplan!
    
    enum LevelNumber : Int {
        case One = 1, Two, Three, Four
    }
    
    init(level: LevelNumber = .One) {
        self.level = level
        createPlan()
    }
    
    func nextLevel() {
        guard level != .Four,
              let level = LevelNumber(rawValue: level.rawValue + 1)
              else { return }
        
        self.level = level
        createPlan()
    }
    
    private func createPlan() {
        self.plan = Floorplan(size: size(for: self.level))
        self.position = self.plan.center
    }
    
    private func size(for level: LevelNumber) -> PlanSize {
        switch level {
        case .One:
            return .Small
        case .Two,
             .Three:
            return .Medium
        case .Four:
            return .Large
        }
    }
}
