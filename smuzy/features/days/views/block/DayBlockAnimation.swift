import SwiftUI

struct DayBlockAnimation: View {
    var blockColor: Color?
    var blockWidth: Double
    var onTap: () -> Void

    @State private var shouldAnimate = false
    private var scalingFactor: CGFloat = 1.2
    @State private var show = false

    init(blockColor: Color?, blockWidth: Double, onTap: @escaping () -> Void) {
        self.blockColor = blockColor
        self.blockWidth = blockWidth
        self.onTap = onTap
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(0.001))
                .frame(width: blockWidth, height: blockWidth)
                .sensoryFeedback(.impact(weight: .light), trigger: show)
                .onTapGesture {
                    onTap()
                    show.toggle()
                }

            if show {
                Rectangle()
                    .fill(blockColor ?? .clear)
                    .frame(width: blockWidth, height: blockWidth)
                    .shadow(radius: shouldAnimate ? 5 : 0)
                    .scaleEffect(shouldAnimate ? scalingFactor : 1)
                    .onAppear {
                        let animation = Animation.easeInOut(duration: 0.1)
                        withAnimation(animation) {
                            shouldAnimate.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(animation) {
                                shouldAnimate.toggle()
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(animation) {
                                show.toggle()
                            }
                        }
                    }
            }
        }
    }
}
