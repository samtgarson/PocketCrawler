//
//  GameState.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 22/12/2021.
//

import Foundation

enum LevelNumber : Int, Equatable {
    case One = 1, Two, Three, Four
}

enum CutScene : Equatable {
    case nextLevel(LevelNumber)
}

enum PlayState : Equatable {
    case cutScene(CutScene)
    case playing
}
