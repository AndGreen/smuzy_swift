import Stripes
import SwiftUI

struct DayBlockView: View {
    @Environment(\.colorScheme) var colorScheme

    var edges: [Edge: CGFloat]
    var blockColor: Color?
    var blockWidth: Double
    var isFuture: Bool = false

    @State private var shouldAnimate = false
    private var scalingFactor: CGFloat = 1.2

    init(edges: [Edge: CGFloat], blockColor: Color?, blockWidth: Double, isFuture: Bool) {
        self.edges = edges
        self.blockColor = blockColor
        self.blockWidth = blockWidth
        self.isFuture = isFuture
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(blockColor ?? .clear)
                .frame(width: blockWidth, height: blockWidth)
                .animation(.easeInOut(duration: 0.2), value: blockColor)
                .sideBorder(widths: edges,
                            color: colorScheme == .dark ?
                                borderColorDark : borderColorLight)

            if isFuture {
                Stripes(config: StripesConfig(background: Color.green.opacity(0),
                                              foreground: Color.black.opacity(0.1), degrees: 45,
                                              barWidth: 2, barSpacing: 5))
                    .frame(width: blockWidth, height: blockWidth)
                    .transition(.opacity)
            }
        }
    }
}

#Preview("Normal") {
    DayBlockView(edges: [:], blockColor: Color.red, blockWidth: 40, isFuture: false)
}

#Preview("Future") {
    DayBlockView(edges: [:], blockColor: Color.red, blockWidth: 40, isFuture: true)
}
