//
//  day_grid_view.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import CoreHaptics
import SwiftUI

let numRows = 8
let numColumns = 8
let timeInterval: TimeInterval = 3 * 60 * 60
let borderColor = Color.black.opacity(0.3)
let textColumnWidth: Double = 50
let paddings: Double = 4

struct DayGridView: View {
    @EnvironmentObject private var appState: AppState
    @State var feedbackGenerator: UIImpactFeedbackGenerator? = nil
    @State private var animationAmount = 1.0

    var body: some View {
        let blockWidth = Double((UIScreen.screenWidth - textColumnWidth) / Double(numColumns)) - paddings

        HStack {
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0 ..< numRows, id: \.self) { row in
                    Text("\(timeText(for: row))")
                        .foregroundColor(.gray.opacity(0.4))
                        .frame(width: 50, height: blockWidth)
                }
            }
            ZStack {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    ForEach(0 ..< numRows, id: \.self) { row in
                        GridRow {
                            ForEach(0 ..< numColumns, id: \.self) { column in
                                let (_, blockColor) = getBlock(row: row, column: column)
                                let edges = getEdges(row: row,
                                                     column: column)

                                DayBlockView(
                                    edges: edges,
                                    blockColor: blockColor,
                                    blockWidth: blockWidth
                                )
                            }
                        }
                    }
                }
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(borderColor, lineWidth: 1)
                )

                Grid(horizontalSpacing: 0, verticalSpacing: 0,
                     content: {
                         ForEach(0 ..< numRows, id: \.self) { row in
                             GridRow {
                                 ForEach(0 ..< numColumns, id: \.self) { column in
                                     let (blockId, blockColor) = getBlock(row: row, column: column)

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
        }
    }

    func getBlock(row: Int, column: Int) -> (blockId: Int, blockColor: Color?) {
        let startBlockId = appState.selectedDate.startOfDay.blockId
        let blockId = startBlockId + row * numColumns + column
        let blockRoutineId = appState.dayGrid[blockId]
        let blockColor = appState.routines.colorMap[blockRoutineId ?? RoutineId()]
        return (blockId, blockColor)
    }

    func getEdges(row: Int, column: Int) -> [Edge] {
        let isFirstRow = row == 0
        let isFirstColumn = column == 0

        var edges: [Edge] = []

        if !isFirstRow { edges.append(.top) }
        if !isFirstColumn { edges.append(.leading) }

        return edges
    }

    func timeText(for row: Int) -> String {
        let timeInSeconds = timeInterval * Double(row)
        let hours = Int(timeInSeconds) / 3600
        let minutes = (Int(timeInSeconds) % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }

    func toggleSelection(blockId: BlockId) {
        appState.dayGrid[blockId] = appState.selectedRoutine?.id ?? nil
        feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        feedbackGenerator?.prepare()
    }
}

#Preview {
    DayGridView()
        .environmentObject(AppState())
}
