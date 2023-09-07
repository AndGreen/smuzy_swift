import SwiftUI

private var animationDuration: TimeInterval = 0.7

struct SplashScreen: View {
    @State private var opacity: Double = 0
    @State private var scale = 0.7
    @State private var yOffset: CGFloat = 50
    @Environment(\.colorScheme) var colorScheme

    @Binding var isActive: Bool
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Smuzy")
                    .font(.system(size: 60, weight: .black))
                    .foregroundStyle(colorScheme == .light ?
                        Color(hex: 0xFF083B0C) : Color(hex: 0xFF7DB01E))
            }.scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.spring(duration: animationDuration)) {
                        self.scale = 1
                        self.opacity = 1
                    }
                }

            Image("Splash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(opacity)
                .offset(y: yOffset)
                .onAppear {
                    withAnimation(.spring(duration: animationDuration)) {
                        self.yOffset = 0
                        self.opacity = 1
                    }
                }
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct PreviewSplashScreen: View {
    @State private var isActive = false

    var body: some View {
        SplashCoordinator()
    }
}

#Preview {
    PreviewSplashScreen()
}
