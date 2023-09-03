import Foundation
import SwiftUI

let numRows = 8
let numColumns = 9
let blockDurationMin = 20

let bgLight = Color(hex: 0xfff9f9fa)
let bgDark = Color(hex: 0xff232325)

let defaultColors: [String: Color] = [
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

let defaultRoutines = [
    Routine(color: defaultColors["blue"]!.toHex, title: "media"),
    Routine(color: defaultColors["green"]!.toHex, title: "sleep"),
    Routine(color: defaultColors["orange"]!.toHex, title: "work"),
    Routine(color: defaultColors["gray"]!.toHex, title: "sport"),
    Routine(color: defaultColors["yellow"]!.toHex, title: "eat")
]
