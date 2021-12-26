//
//  CoreStateWrapper.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 21/12/2021.
//

import SwiftUI

struct PreviewWrapper<Content : View>: View {
    init(level: LevelNumber = .One, children: @escaping (CoreState) -> Content) {
        self.level = level
        self.state = CoreState(level: level)
        self.children = children
    }
    
    var level: LevelNumber
    @State var state: CoreState
    @ViewBuilder var children: (CoreState) -> Content
    
    var body: some View {
        Group {
            children(state)
        }.environmentObject(Router())
    }
}

struct CoreStateWrapper_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper() { _ in
            Text("hello")
        }
    }
}
