import Foundation

extension Date {
    var blockId: BlockId {
        let timestamp = Int(timeIntervalSince1970 * 1000)
        let blockId = Int(floor(Double(timestamp) / 1000 / 1200))
        return blockId
    }

    var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    func getFormattedDayLabel() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        let dayOfWeek = formatter.string(from: self)
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: self)
        let now = calendar.startOfDay(for: Date())
        let diffNow = -(calendar.dateComponents([.day], from: startOfDay, to: now).day ?? 0)
        
        var formattedDate = ""
        
        switch diffNow {
        case 0:
            formattedDate = "Today - \(dayOfWeek)"
        case 1:
            formattedDate = "Tomorrow - \(dayOfWeek)"
        case -1:
            formattedDate = "Yesterday - \(dayOfWeek)"
        default:
            formatter.dateFormat = "MM.dd.yy - "
            formattedDate = formatter.string(from: self) + dayOfWeek
        }
        
        return formattedDate.lowercased()
    }
    
    func getBlockId(offset: Int? = nil) -> BlockId {
        let timestamp = Int(timeIntervalSince1970 * 1000)
        let blocks = Int(floor(Double(timestamp) / 1000 / 1200))
        let id = blocks + (offset ?? 0)
        return id
    }
    
    func getDayBlockRange() -> ClosedRange<Int> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: self)
        let firstDayBlockID = startOfDay.getBlockId()
        return firstDayBlockID ... (firstDayBlockID + numRows * numColumns)
    }
}
