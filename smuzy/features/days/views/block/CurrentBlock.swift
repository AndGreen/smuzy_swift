import SwiftUI

struct CurrentBlock: View {
    var routines: [Routine]
    var blockWidth: CGFloat
    @Binding var currentBlockId: BlockId
    @Environment(AppState.self) var appState
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        let startOfDayBlockId = appState.selectedDate.startOfDay.blockId
        let endOfDayBlockId = appState.selectedDate.endOfDay.blockId
        if currentBlockId >= startOfDayBlockId && currentBlockId <= endOfDayBlockId {
            let diff = currentBlockId - appState.selectedDate.startOfDay.blockId
            let row: Int = diff / numColumns
            let column: Int = diff % numColumns

            let (_, blockColor) = appState.getBlock(routines: routines, row: row, column: column)
            let bgColor: Color = colorScheme == .dark ? bgDark : bgLight

            Rectangle()
                .fill(.clear)
                .frame(width: blockWidth, height: blockWidth)
                .background(
                    Rectangle()
                        .fill((blockColor ?? bgColor).shadow(.drop(color: .black.opacity(0.8), radius: 3, x: 0, y: 0)))
                        .stroke(.blue, lineWidth: 3)
                )
                .offset(x: blockWidth * CGFloat(column), y: blockWidth * CGFloat(row))
        }
    }
}
