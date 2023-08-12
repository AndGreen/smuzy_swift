//
//  AppState.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var routines: [Routine] = [
        Routine(color: .blue, title: "media"),
        Routine(color: .green, title: "sleep"),
        Routine(color: .orange, title: "work"),
        Routine(color: .gray, title: "sport"),
        Routine(color: .yellow, title: "eat")
    ]
    @Published var colors: [String: Color] = [
        "red": Color(hex: 0xffe25241),
        "pink": Color(hex: 0xffd73965),
        "purple": Color(hex: 0xff9037aa),
        "deepPurple": Color(hex: 0xff6041b1),
        "indigo": Color(hex: 0xff4154af),
        "blue": Color(hex: 0xff4696ec),
        "cyan": Color(hex: 0xff53bad1),
        "teal": Color(hex: 0xff419488),
        "green": Color(hex: 0xff67ac5c),
        "lightGreen": Color(hex: 0xffd1da59),
        "yellow": Color(hex: 0xfffdea60),
        "orange": Color(hex: 0xfff29c38),
        "brown": Color(hex: 0xff74564a),
        "gray": Color(hex: 0xff9e9e9e),
        "blueGray": Color(hex: 0xff667d8a),
        "black": Color(hex: 0xff344047)
    ]
    @Published var activeRoutine: Routine? = nil

    func updateActiveRoutine(routine: Routine?) {
        activeRoutine = routine
    }
}

extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xff) / 255.0
        let green = Double((hex >> 8) & 0xff) / 255.0
        let blue = Double(hex & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
