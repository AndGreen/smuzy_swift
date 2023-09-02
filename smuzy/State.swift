import Foundation
import SwiftUI

typealias BlockId = Int
typealias RoutineId = UUID
typealias Blocks = [BlockId: RoutineId]

@Observable
class AppState {
    var routines: [Routine]
    var dayGrid: Blocks
    var selectedDate: Date
    var selectedRoutine: Routine?

    init(
        selectedRoutine: Routine? = nil,
        routines: [Routine] = [],
        dayGrid: Blocks = [:],
        selectedDate: Date = .init())
    {
        self.selectedRoutine = selectedRoutine
        self.routines = routines
        self.dayGrid = dayGrid
        self.selectedDate = selectedDate
    }
}
