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
let timeInterval: TimeInterval = 3 * 60 * 60 // 3 hours in seconds

struct DayGridView: View {
    @EnvironmentObject private var appState: AppState
    @State var feedbackGenerator: UIImpactFeedbackGenerator? = nil

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<numRows, id: \.self) { row in
                HStack(spacing: 0) {
                    Text("\(timeText(for: row))")
                        .foregroundColor(.gray.opacity(0.4))
                        .frame(width: 60, height: 40)

                    ForEach(0..<numColumns, id: \.self) { column in
                        let startBlockId = appState.selectedDate.startOfDay.blockId
                        let blockId = startBlockId + row * numColumns + column
                        let blockRoutineId = appState.dayGrid[blockId]
                        let blockColor = appState.routines.colorMap[blockRoutineId ?? RoutineId()] ?? Color.white.opacity(0.001) // fix it

                        let isLastRow = row == numRows - 1
                        let isLastColumn = column == numColumns - 1

                        let edges = getEdges(isLastRow: isLastRow,
                                             isLastColumn: isLastColumn)

                        Rectangle()
                            .fill(blockColor)
                            .frame(width: 40, height: 40)
                            .sideBorder(width: 1,
                                        edges: edges,
                                        color: Color.black.opacity(0.3))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    toggleSelection(blockId: blockId)
                                }
                            }
                    }
                }
            }
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
        .padding()
        .padding(.trailing, 5)
    }

    func getEdges(isLastRow: Bool, isLastColumn: Bool) -> [Edge] {
        var edges: [Edge] = [.top, .leading]
        if isLastRow { edges.append(.bottom) }
        if isLastColumn { edges.append(.trailing) }
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
