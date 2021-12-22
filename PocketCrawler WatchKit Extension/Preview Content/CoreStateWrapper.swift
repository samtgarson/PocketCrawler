//
//  CoreStateWrapper.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 21/12/2021.
//

import SwiftUI

struct CoreStateWrapper<Content : View>: View {
    @ObservedObject var state = CoreState()
    @ViewBuilder var children: (CoreState) -> Content
    
    var body: some View {
        Group {
            children(state)
        }
    }
}

struct CoreStateWrapper_Previews: PreviewProvider {
    static var previews: some View {
        CoreStateWrapper() { _ in
            Text("hello")
        }
    }
}
