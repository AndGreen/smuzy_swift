import SwiftUI

struct DayBlockView: View {
    var edges: [Edge]
    var blockColor: Color?
    var onTap: () -> Void

    @State private var shouldAnimate = false
    private var scalingFactor: CGFloat = 1.2

    init(edges: [Edge], blockColor: Color? = nil, onTap: @escaping () -> Void) {
        self.edges = edges
        self.blockColor = blockColor
        self.onTap = onTap
    }

    var body: some View {
        Rectangle()
            .fill(.white.opacity(0.001))
            .frame(width: 40, height: 40)
            .sideBorder(width: 1,
                        edges: edges,
                        color: Color.black.opacity(0.3))
            .overlay(
                blockColor != nil ?
                    Rectangle()
                    .fill(blockColor!)
                    .scaleEffect(self.shouldAnimate ? self.scalingFactor : 1)
                    .onAppear {
                        let animation = Animation.easeInOut(duration: 0.05).repeatCount(1, autoreverses: true)
                        withAnimation(animation) {
                            self.shouldAnimate.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(animation) {
                                self.shouldAnimate.toggle()
                            }
                        }
                    }
                    : nil
            )
            .onTapGesture(perform: onTap)
    }
}
