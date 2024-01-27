import SwiftUI
import SwiftData

typealias BlockId = Int
typealias RoutineId = UUID
typealias Blocks = [BlockId: RoutineId]

@Observable
class AppState {
    var dayGrid: Blocks
    var selectedDate: Date
    var selectedRoutine: Routine?

    init(
        selectedRoutine: Routine? = nil,
        dayGrid: Blocks = [:],
        selectedDate: Date = .init())
    {
        self.selectedRoutine = selectedRoutine
        self.dayGrid = dayGrid
        self.selectedDate = selectedDate
    }

    func getBlock(routines: [Routine], row: Int, column: Int) -> (blockId: Int, blockColor: Color?) {
        let selectedDayStartBlockId = selectedDate.startOfDay.blockId
        let blockId = selectedDayStartBlockId + row * numColumns + column
        let blockRoutineId = dayGrid[blockId]
        let blockColor = routines.colorMap[blockRoutineId ?? RoutineId()]
        return (blockId, blockColor)
    }
    
    func loadDayGrid(modelContext: ModelContext) {
        dayGrid = Block.loadDayGrid(date: selectedDate, modelContext: modelContext)
    }
}
