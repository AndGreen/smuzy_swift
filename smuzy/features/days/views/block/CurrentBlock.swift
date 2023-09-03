//
//  CurrentBlock.swift
//  smuzy
//
//  Created by Andrey Zelenin on 03.09.2023.
//

import SwiftUI

struct CurrentBlock: View {
    var routines: [Routine]
    var blockWidth: CGFloat
    @Environment(AppState.self) var appState
    @Environment(\.colorScheme) var colorScheme
    @State private var currentBlockId = Date.now.blockId
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

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
                        .fill((blockColor ?? bgColor).shadow(.drop(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)))
                        .stroke(.blue, lineWidth: 2)
                )
                .onReceive(timer) { input in
                    let newCurrentBlockId = input.blockId
                    if currentBlockId != newCurrentBlockId {
                        withAnimation {
                            currentBlockId = newCurrentBlockId
                        }
                    }
                }
                .offset(x: blockWidth * CGFloat(column), y: blockWidth * CGFloat(row))
        }
    }
}
