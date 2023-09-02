import Foundation
import SwiftUI

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
}
