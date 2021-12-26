//
//  CutSceneRenderer.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 22/12/2021.
//

import SwiftUI

struct CompleteScreen: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("🥱")
                .font(.title)
                .multilineTextAlignment(.center)
            Text("You're tired, time to head home for some tea.")
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            Button("🏡 Go home", action: exit)
        }.foregroundColor(.white)
    }
    
    private func exit() {
        router.go(to: .home)
    }
}

struct CompleteScreen_Previews: PreviewProvider {
    static var previews: some View {
        CompleteScreen()
            .environmentObject(Router())
    }
}
