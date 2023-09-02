import SwiftData
import SwiftUI

@Model
class Block {
    var id: RoutineId
    var routineId: RoutineId

    init(id: UUID = UUID(), routineId: RoutineId) {
        self.id = id
        self.routineId = routineId
    }
}
