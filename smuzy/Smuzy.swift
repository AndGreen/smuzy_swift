//
//  smuzyApp.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

@main
struct smuzyApp: App {
    var body: some Scene {
        @State var appState = AppState()

        WindowGroup {
            AppView()
                .environment(appState)
                .modelContainer(for: [Routine.self, Block.self])
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
