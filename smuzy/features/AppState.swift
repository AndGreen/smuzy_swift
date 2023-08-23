import Foundation
import SwiftUI

typealias BlockId = Int
typealias RoutineId = UUID
typealias Blocks = [BlockId: RoutineId]

class AppState: ObservableObject {
    @Published var routines: [Routine]
    @Published var dayGrid: Blocks
    @Published var selectedDate: Date
    @Published var selectedRoutine: Routine?

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
