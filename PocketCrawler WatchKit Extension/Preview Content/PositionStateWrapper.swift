//
//  PositionStateWrapper.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 21/12/2021.
//

import SwiftUI

struct PositionStateWrapper<Content : View>: View {
    @ObservedObject var state = PositionState()
    @ViewBuilder var children: (PositionState) -> Content
    
    var body: some View {
        Group {
            children(state)
        }
    }
}

struct PositionStateWrapper_Previews: PreviewProvider {
    static var previews: some View {
        PositionStateWrapper() { _ in
            Text("hello")
        }
    }
}
