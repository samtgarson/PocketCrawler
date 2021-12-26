//
//  ContentView.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 30/07/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var router = Router()
    
    var body: some View {
        ScreenSize { size in
            ZStack {
                if router.route == .home {
                    home.frame(width: size.width, height: size.height)
                }
                if router.route == .game {
                    game.frame(width: size.width, height: size.height)
                }
            }.environmentObject(router)
        }
    }
    
    private var home: some View {
        TabView {
            Text("Home").tabItem { Text("Home") }
            MainMenu().tabItem { Text("Menu") }
        }.transition(homeTransition)
    }
    
    private var game: some View {
        GameRenderer()
            .transition(gameTransition)
    }
    
    private var homeTransition: AnyTransition {
        .asymmetric(
            insertion: .opacity.animation(.easeOut.delay(0.3)),
            removal: .opacity.animation(.easeOut)
        )
    }
    
    private var gameTransition: AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 0.5)).animation(.easeOut.delay(0.3)),
            removal: .opacity.combined(with: .scale(scale: 0.5)).animation(.easeOut)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
