import CoreHaptics
import SwiftData
import SwiftUI

let timeInterval: TimeInterval = 3 * 60 * 60
let borderColorLight = Color.black.opacity(0.3)
let borderColorDark = Color.black
let textColumnWidth: Double = 50
let paddings: Double = 2

struct DayGridView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(AppState.self) var appState
    @Environment(\.modelContext) var modelContext
    @Query private var routines: [Routine]
    @State private var animationAmount = 1.0
    @State private var currentBlockId = Date.now.blockId
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        let blockWidth = Double((UIScreen.screenWidth - textColumnWidth) / Double(numColumns)) - paddings

        HStack {
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0 ..< numRows, id: \.self) { row in
                    Text("\(timeText(for: row))")
                        .foregroundColor(colorScheme == .dark ? .white.opacity(0.2) : borderColorLight)
                        .font(.system(size: 15))
                        .frame(width: 42, height: blockWidth)
                }
            }
            ZStack(alignment: .topLeading) {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    ForEach(0 ..< numRows, id: \.self) { row in
                        GridRow {
                            ForEach(0 ..< numColumns, id: \.self) { column in
                                let (blockId, blockColor) = appState.getBlock(routines: routines, row: row, column: column)

                                let edges = getEdges(row: row,
                                                     column: column)

                                let isFuture = blockId > currentBlockId && blockColor != nil

                                DayBlockView(
                                    edges: edges,
                                    blockColor: blockColor,
                                    blockWidth: blockWidth,
                                    isFuture: isFuture
                                )
                            }
                        }
                    }
                }.background(colorScheme == .dark ? bgDark : .clear)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(colorScheme == .dark ? borderColorDark : borderColorLight, lineWidth: 1)
                    )

                CurrentBlock(
                    routines: routines,
                    blockWidth: blockWidth,
                    currentBlockId: $currentBlockId
                )

                Grid(horizontalSpacing: 0, verticalSpacing: 0,
                     content: {
                         ForEach(0 ..< numRows, id: \.self) { row in
                             GridRow {
                                 ForEach(0 ..< numColumns, id: \.self) { column in
                                     let (blockId, blockColor) = appState.getBlock(routines: routines, row: row, column: column)

                                     DayBlockAnimation(
                                         blockColor: blockColor,
                                         blockWidth: blockWidth,
                                         onTap: {
                                             toggleSelection(blockId: blockId)
                                         }
                                     )
                                 }
                             }
                         }
                     })
            }
            .gesture(DragGesture(minimumDistance: 50, coordinateSpace: .local)
                .onEnded { value in
                    let calendar = Calendar.current
                    let selectedDate = appState.selectedDate
                    if value.translation.width < 0 {
                        appState.selectedDate = calendar.date(byAdding: .day, value: 1, to: selectedDate)!
                    }

                    if value.translation.width > 0 {
                        appState.selectedDate = calendar.date(byAdding: .day, value: -1, to: selectedDate)!
                    }
                })
            .onReceive(timer) { input in
                let newCurrentBlockId = input.blockId
                if currentBlockId != newCurrentBlockId {
                    withAnimation {
                        currentBlockId = newCurrentBlockId
                    }
                }
            }
        }
    }

    func getEdges(row: Int, column: Int) -> [Edge: CGFloat] {
        let isFirstRow = row == 0
        let isFirstColumn = column == 0

        var edges: [Edge: CGFloat] = [:]

        if !isFirstRow { edges[.top] = 1 }
        if !isFirstColumn {
            edges[.leading] = column % 3 == 0 ? 2.5 : 1
        }

        return edges
    }

    func timeText(for row: Int) -> String {
        let timeInSeconds = timeInterval * Double(row)
        let hours = Int(timeInSeconds) / 3600
        let minutes = (Int(timeInSeconds) % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }

    func toggleSelection(blockId: BlockId) {
        let newBlockRoutineId = appState.selectedRoutine?.id ?? nil
        let existBlock = Block.loadBlock(blockId: blockId, modelContext: modelContext)
        if existBlock != nil {
            if newBlockRoutineId != nil {
                existBlock?.routineId = newBlockRoutineId!
            } else {
                modelContext.delete(existBlock!)
            }
        }
        if existBlock == nil && newBlockRoutineId != nil {
            modelContext.insert(Block(id: blockId, routineId: newBlockRoutineId!))
        }

        appState.dayGrid[blockId] = newBlockRoutineId
    }
}

#Preview {
    DayGridView()
        .environment(AppState())
}
