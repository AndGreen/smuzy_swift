import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
            opacity: alpha
        )
    }

    var hex: UInt {
        let components = self.cgColor?.components
        let r = components?[0] ?? 0
        let g = components?[1] ?? 0
        let b = components?[2] ?? 0

        let red = UInt(r * 255) << 16
        let green = UInt(g * 255) << 08
        let blue = UInt(b * 255)

        return red | green | blue
    }
}
