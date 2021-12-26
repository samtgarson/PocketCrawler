//
//  Router.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 22/12/2021.
//

import SwiftUI

class Router : ObservableObject {
    @Published var route: Route = .home
    
    func go(to route: Route) {
        withAnimation {
            self.route = route
        }
    }
    
    enum Route {
        case home, game
    }
}
