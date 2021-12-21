//
//  GameState.swift
//  GameState
//
//  Created by Sam Garson on 15/08/2021.
//

import Foundation

class PositionState : ObservableObject {
    @Published var level: LevelNumber
    @Published var position: Coordinate!
    @Published var plan: Floorplan!
    
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
    
    func move(_ direction: Direction) {
        let newLoc = position.neighbour(direction)
        precondition(currentRoom.canMove(in: direction), "Cannot move in that direction.")
        
        self.position = newLoc
    }
    
    var currentRoom: RoomEntry {
        guard let room = plan.at(position) else { preconditionFailure("Not allowed to be here") }
        return room
    }
    
    private func createPlan() {
        self.plan = FloorplanGenerator(size: size(for: self.level)).generate()
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