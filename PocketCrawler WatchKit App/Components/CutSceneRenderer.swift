//
//  CutSceneRenderer.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 22/12/2021.
//

import SwiftUI

let CUTSCENE_LENGTH = 2.0

struct CutSceneRenderer: View {
    var scene: CutScene
    
    var body: some View {
        VStack {
            Spacer()
            contents
            Spacer()
        }
    }
    
    var contents: some View {
        switch scene {
        case .nextLevel(let level):
            return Text("Going to level \(level.rawValue)").foregroundColor(.white)
        }
    }
}

struct CutSceneRenderer_Previews: PreviewProvider {
    static var previews: some View {
        CutSceneRenderer(scene: .nextLevel(.Two))
    }
}
