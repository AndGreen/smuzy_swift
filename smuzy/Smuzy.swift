//
//  smuzyApp.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftData
import SwiftUI

@main
struct smuzyApp: App {
    var body: some Scene {
        @StateObject var appState = AppState()

        WindowGroup {
            AppView()
                .environmentObject(appState)
                .modelContainer(for: [Routine.self, UserModel.self])
        }
    }

    func initNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance =
            UINavigationBar.appearance().standardAppearance
    }
}
