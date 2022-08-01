//
//  Beer_CounterApp.swift
//  Beer Counter WatchKit Extension
//
//  Created by Jan Janovec on 29.07.2022.
//

import SwiftUI

@main
struct Beer_CounterApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
