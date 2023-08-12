//
//  AppState.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import Foundation

class AppState: ObservableObject {
    @Published var routines: [Routine] = [
        Routine(color: .blue, title: "media"),
        Routine(color: .green, title: "sleep"),
        Routine(color: .orange, title: "work"),
        Routine(color: .gray, title: "sport"),
        Routine(color: .yellow, title: "eat")
    ]
    @Published var activeRoutine: Routine? = nil
}
