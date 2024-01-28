import SwiftUI

struct Backup: Codable {
    var routines: [Routine]
    var blocks: [Block]
}

extension Backup: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
            .suggestedFileName(Date().getBackupFileName())
    }
}
