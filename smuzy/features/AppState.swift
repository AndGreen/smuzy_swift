import Foundation
import SwiftData
import SwiftUI

typealias BlockId = Int
typealias RoutineId = UUID
typealias Blocks = [BlockId: RoutineId?]

class AppState: ObservableObject {
    @Published var user: User
    @Published var selectedRoutine: Routine?
    @Published var routines: [Routine]
    @Published var dayGrid: Blocks
    @Published var selectedDate: Date

    init(user: User = User(history: [:],
                           routines: []),
         selectedRoutine: Routine? = nil,
         routines: [Routine] = [],
         dayGrid: Blocks = [:],
         selectedDate: Date = .init())
    {
        self.user = user
        self.selectedRoutine = selectedRoutine
        self.routines = routines
        self.dayGrid = dayGrid
        self.selectedDate = selectedDate
    }

    func saveUser(context: ModelContext) {
        dayGrid.forEach { (_: BlockId, _: RoutineId?) in
        }
        let newUser = UserModel(history: dayGrid, routines: routines)
        context.insert(newUser)
    }
}
