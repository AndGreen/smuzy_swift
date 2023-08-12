//
//  day_grid_view.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct DayGridView: View {
    @State private var selectedIndices: Set<Int> = []

    let numRows = 8
    let numColumns = 8

    let timeInterval: TimeInterval = 3 * 60 * 60 // 3 hours in seconds

    let activeColor: Color // The active color for selected rectangles

    init(activeColor: Color = .blue) {
        self.activeColor = activeColor
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<numRows, id: \.self) { row in
                HStack(spacing: 0) {
                    Text("\(timeText(for: row))")
                        .foregroundColor(.gray)
                        .frame(width: 60, height: 40)

                    ForEach(0..<numColumns, id: \.self) { column in
                        Rectangle()
                            .fill(selectedIndices.contains(row * numColumns + column) ? activeColor : Color.clear)
                            .frame(width: 40, height: 40)
                            .border(Color.black.opacity(0.5))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    toggleSelection(row: row, column: column)
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

    func toggleSelection(row: Int, column: Int) {
        let index = row * numColumns + column
        if selectedIndices.contains(index) {
            selectedIndices.remove(index)
        } else {
            selectedIndices.insert(index)
        }
    }
}

struct DayGridView_previews: PreviewProvider {
    static var previews: some View {
        DayGridView(activeColor: .red)
    }
}
