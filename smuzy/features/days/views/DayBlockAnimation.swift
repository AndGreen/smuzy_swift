import SwiftUI

struct DayBlockAnimation: View {
    var blockColor: Color?
    var onTap: () -> Void

    @State private var shouldAnimate = false
    private var scalingFactor: CGFloat = 1.2
    @State private var show = false

    init(blockColor: Color?, onTap: @escaping () -> Void) {
        self.blockColor = blockColor
        self.onTap = onTap
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(0.001))
                .frame(width: 40, height: 40)
                .onTapGesture {
                    onTap()
                    show.toggle()
                }

            if blockColor != nil && show {
                Rectangle()
                    .fill(blockColor!)
                    .frame(width: 40, height: 40)
                    .shadow(radius: shouldAnimate ? 5 : 0)
                    .scaleEffect(shouldAnimate ? scalingFactor : 1)

                    .onAppear {
                        let animation = Animation.easeInOut(duration: 0.1).repeatCount(1, autoreverses: true)
                        withAnimation(animation) {
                            shouldAnimate.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
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
