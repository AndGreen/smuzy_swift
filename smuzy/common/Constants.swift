import Foundation
import SwiftUI

let numRows = 8
let numColumns = 9
let blockDurationMin = 20

let bgLight = Color(hex: 0xfff9f9fa)
let bgDark = Color(hex: 0xff232325)

let defaultColors: [String: UInt] = [
    "red": 0xffe25241,
    "pink": 0xffd73965,
    "purple": 0xff9037aa,
    "deepPurple": 0xff6041b1,
    "indigo": 0xff4154af,
    "blue": 0xff4696ec,
    "cyan": 0xff53bad1,
    "teal": 0xff419488,
    "green": 0xff67ac5c,
    "lightGreen": 0xffd1da59,
    "yellow": 0xfffdea60,
    "orange": 0xfff29c38,
    "brown": 0xff74564a,
    "gray": 0xff9e9e9e,
    "blueGray": 0xff667d8a,
    "black": 0xff344047
]

let defaultRoutines = [
    Routine(color: defaultColors["blue"]!, title: "media"),
    Routine(color: defaultColors["green"]!, title: "sleep"),
    Routine(color: defaultColors["orange"]!, title: "work"),
    Routine(color: defaultColors["gray"]!, title: "sport"),
    Routine(color: defaultColors["yellow"]!, title: "eat")
]

struct Constants {
    static let fileNameDateFormat = "dd_MM_yyyy"
}
