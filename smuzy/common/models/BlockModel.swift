import SwiftData
import SwiftUI

@Model
class Block {
    var id: BlockId
    var routineId: RoutineId

    init(id: BlockId, routineId: RoutineId) {
        self.id = id
        self.routineId = routineId
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
