import SwiftData
import SwiftUI

@Model
class Routine {
    var id: RoutineId
    var createAt: Date
    var color: String
    var title: String

    init(id: UUID = UUID(), color: String, title: String, createAt: Date = Date.now) {
        self.id = id
        self.createAt = createAt
        self.color = color
        self.title = title
    }
}

extension [Routine] {
    var colorMap: [RoutineId: Color] {
        return self.reduce(into: [:]) { result, routine in
            result[routine.id] = Color.fromHex(routine.color)
        }
    }
}
