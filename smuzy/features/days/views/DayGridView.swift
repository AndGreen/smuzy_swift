//
//  day_grid_view.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

let numRows = 8
let numColumns = 8
let timeInterval: TimeInterval = 3 * 60 * 60 // 3 hours in seconds

struct DayGridView: View {
    @EnvironmentObject private var appState: AppState

    var dayGrid: Blocks
    var colorMap: [RoutineId: Color?]

    init(dayGrid: Blocks, colorMap: [RoutineId: Color?]) {
        self.dayGrid = dayGrid
        self.colorMap = colorMap
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<numRows, id: \.self) { row in
                HStack(spacing: 0) {
                    Text("\(timeText(for: row))")
                        .foregroundColor(.gray)
                        .frame(width: 60, height: 40)

                    ForEach(0..<numColumns, id: \.self) { column in
                        let startBlockId = Date().startOfDay.blockId
                        let blockId = startBlockId + row * numColumns + column
                        let blockRoutineId = dayGrid[blockId] ?? UUID()
                        let blockColor = blockRoutineId != nil ? colorMap[blockRoutineId!] : .clear

                        Rectangle()
                            .fill((blockColor ?? .clear) ?? .clear)
                            .frame(height: 40)
                            .border(Color.black.opacity(0.5))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    toggleSelection(blockId: blockId)
                                }
                            }
                    }
                }
            }
        }
        .padding()
        .padding(.trailing, 5)
    }

    func timeText(for row: Int) -> String {
        let timeInSeconds = timeInterval * Double(row)
        let hours = Int(timeInSeconds) / 3600
        let minutes = (Int(timeInSeconds) % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }

    func toggleSelection(blockId: BlockId) {
        print(blockId)
        appState.dayGrid[blockId] = appState.selectedRoutine?.id ?? nil
    }
}

#Preview {
    DayGridView(dayGrid: [:], colorMap: [:])
        .environmentObject(AppState())
}
