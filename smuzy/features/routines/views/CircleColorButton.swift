import CoreHaptics
import SwiftUI

struct CircleColorButton: View {
    var color: UInt
    var onTap: (_ color: UInt) -> Void
    var isActive: Bool
    var isUsed: Bool

    @State private var isPressed = false
    @State var feedbackGenerator: UIImpactFeedbackGenerator? = nil
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Circle()
                .stroke(colorScheme == .dark ? .white :
                    .black, lineWidth: isActive ? 2 : 0)
                .fill(Color(hex: color))
                .frame(width: 60, height: 60)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .opacity(isUsed ? 0.4 : 1)
                .sensoryFeedback(.impact(weight: .light), trigger: isPressed)
                .pressEvents {
                    if !(isUsed || isActive) {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isPressed = true
                        }
                    }
                } onRelease: {
                    if !(isUsed || isActive) {
                        withAnimation(.spring) {
                            isPressed = false
                            onTap(color)
                        }
                    }
                }

            if isActive {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            }

            if isUsed {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .opacity(colorScheme == .dark ? 0.2 : 1)
            }
        }
    }
}

#Preview("Default") {
    CircleColorButton(color: defaultColors["red"]!, onTap: { _ in }, isActive: false, isUsed: false)
}

#Preview("Active") {
    CircleColorButton(color: defaultColors["blue"]!, onTap: { _ in }, isActive: true, isUsed: false)
}

#Preview("Used") {
    CircleColorButton(color: defaultColors["green"]!, onTap: { _ in }, isActive: false, isUsed: true)
}
