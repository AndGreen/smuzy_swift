import SwiftUI

struct CircleColorButton: View {
    var color: Color
    var onTap: (_ color: Color) -> Void
    var isActive: Bool

    @State private var isPressed = false
    @State var feedbackGenerator: UIImpactFeedbackGenerator? = nil

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
                .opacity(isPressed ? 0.4 : 1.0)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .pressEvents {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                    }
                } onRelease: {
                    withAnimation(.spring) {
                        isPressed = false
                        onTap(color)
                        feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                        feedbackGenerator?.prepare()
                    }
                }

            if isActive {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            }
        }
    }
}

#Preview("Default") {
    CircleColorButton(color: defaultColors["red"]!, onTap: { _ in }, isActive: false)
}

#Preview("Active") {
    CircleColorButton(color: defaultColors["blue"]!, onTap: { _ in }, isActive: true)
}
