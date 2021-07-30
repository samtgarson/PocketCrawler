//
//  PocketCrawlerApp.swift
//  PocketCrawler WatchKit Extension
//
//  Created by Sam Garson on 30/07/2021.
//

import SwiftUI

@main
struct PocketCrawlerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
