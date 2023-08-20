import SwiftUI

struct DayBlockView: View {
    @Environment(\.colorScheme) var colorScheme

    var edges: [Edge]
    var blockColor: Color?
    var blockWidth: Double

    @State private var shouldAnimate = false
    private var scalingFactor: CGFloat = 1.2

    init(edges: [Edge], blockColor: Color?, blockWidth: Double) {
        self.edges = edges
        self.blockColor = blockColor
        self.blockWidth = blockWidth
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(blockColor ?? .clear)
                .frame(width: blockWidth, height: blockWidth)
                .animation(.easeInOut(duration: 0.2), value: blockColor)
                .sideBorder(width: 1,
                            edges: edges,
                            color: colorScheme == .dark ?
                                borderColorDark : borderColorLight)
        }
    }
}
