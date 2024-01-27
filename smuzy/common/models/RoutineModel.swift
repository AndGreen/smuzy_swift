import SwiftData
import SwiftUI

@Model
class Routine: Codable {
    var id: RoutineId
    var createAt: Date
    var color: UInt
    var title: String

    init(id: UUID = UUID(), color: UInt, title: String, createAt: Date = Date.now) {
        self.id = id
        self.createAt = createAt
        self.color = color
        self.title = title
    }

    enum CodingKeys: CodingKey {
        case id
        case createAt
        case color
        case title
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(RoutineId.self, forKey: .id)
        createAt = try container.decode(Date.self, forKey: .createAt)
        color = try container.decode(UInt.self, forKey: .color)
        title = try container.decode(String.self, forKey: .title)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createAt, forKey: .createAt)
        try container.encode(color, forKey: .color)
        try container.encode(title, forKey: .title)
    }
}

extension [Routine] {
    var colorMap: [RoutineId: Color] {
        return self.reduce(into: [:]) { result, routine in
            result[routine.id] = Color(hex: routine.color)
        }
    }
}
