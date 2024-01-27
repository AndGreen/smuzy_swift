import SwiftData
import SwiftUI

@Model
class Block: Codable {
    var id: BlockId
    var routineId: RoutineId

    init(id: BlockId, routineId: RoutineId) {
        self.id = id
        self.routineId = routineId
    }

    enum CodingKeys: CodingKey {
        case id
        case routineId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(BlockId.self, forKey: .id)
        routineId = try container.decode(RoutineId.self, forKey: .routineId)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(routineId, forKey: .routineId)
    }
}

extension Block {
    static func loadDayGrid(date: Date, modelContext: ModelContext) -> Blocks {
        let (startBlockId, endBlockId) = date.getDayBlockRange()

        let descriptor = FetchDescriptor(predicate:
            #Predicate<Block> { block in
                block.id >= startBlockId && block.id <= endBlockId
            })

        let dayBlocks = try! modelContext.fetch(descriptor)

        var result: Blocks = [:]

        dayBlocks.forEach { block in
            result[block.id] = block.routineId
        }

        return result
    }

    static func loadBlock(blockId: BlockId, modelContext: ModelContext) -> Block? {
        let descriptor = FetchDescriptor(predicate:
            #Predicate<Block> { block in
                block.id == blockId
            })
        let dayBlocks = try! modelContext.fetch(descriptor)
        return dayBlocks.first
    }
}
