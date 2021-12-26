//
//  InGameMenu.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 23/12/2021.
//

import SwiftUI


struct InGameMenu: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Button("Go home early") { router.go(to: .home) }
            Spacer()
        }
    }
}

struct InGameMenu_Previews: PreviewProvider {
    static var previews: some View {
        InGameMenu()
            .environmentObject(Router())
    }
}
