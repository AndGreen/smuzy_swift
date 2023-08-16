import SwiftUI

extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }

    var toHex: String {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return "#000000"
        }

        let red = UInt8(components[0] * 255.0)
        let green = UInt8(components[1] * 255.0)
        let blue = UInt8(components[2] * 255.0)
        let alpha = UInt8(components.count == 4 ? components[3] * 255.0 : 255.0)

        return String(format: "#%02X%02X%02X%02X", red, green, blue, alpha)
    }

    static func fromHex(_ hex: String) -> Color {
        let hexSanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF000000) >> 24) / 255.0
        let green = Double((rgb & 0x00FF0000) >> 16) / 255.0
        let blue = Double((rgb & 0x0000FF00) >> 8) / 255.0
        let alpha = Double(rgb & 0x000000FF) / 255.0

        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}
