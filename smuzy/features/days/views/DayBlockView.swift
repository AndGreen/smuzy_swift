import SwiftUI

struct DayBlockView: View {
    var edges: [Edge]
    var blockColor: Color?

    @State private var shouldAnimate = false
    private var scalingFactor: CGFloat = 1.2

    init(edges: [Edge], blockColor: Color?) {
        self.edges = edges
        self.blockColor = blockColor
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(blockColor ?? .white.opacity(0.001))
                .frame(width: 40, height: 40)
                .sideBorder(width: 1,
                            edges: edges,
                            color: Color.black.opacity(0.3))
        }
    }
}
