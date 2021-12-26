//
//  Menu.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 22/12/2021.
//

import SwiftUI

struct MainMenu: View {
    @EnvironmentObject var router: Router
    @State var showCredits = false
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            Button("New adventure") { router.go(to: .game) }
            Button("About") { showCredits.toggle() }
                .buttonStyle(.plain)
                .padding(12)
                .frame(maxWidth: .infinity)
            Spacer()
        }
        .sheet(isPresented: $showCredits) { credits }
    }
    
    private var credits: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Made with ❤ by Sam Garson")
            Text("🌐 samgarson.com")
            Text("🐤 @samtgarson")
        }
        .font(.footnote)
        .padding(.vertical, 50)
    }
    
    private var title: some View {
        Text("Game title")
            .font(.headline).padding(.bottom, 10)
            .padding(.bottom, 10)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
            .environmentObject(Router())
    }
}
