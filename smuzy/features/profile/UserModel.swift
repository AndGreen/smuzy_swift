//
//  AppData.swift
//  smuzy
//
//  Created by Andrey Zelenin on 13.08.2023.
//

import SwiftData
import SwiftUI

@Model
class UserModel {
    @Attribute(.unique) var id: UUID
    var history: Blocks

    @Relationship()
    var routines: [Routine]

    init(history: Blocks,
         routines: [Routine] = [])
    {
        self.id = UUID()
        self.history = history
        self.routines = routines
    }
}

class User {
    var id: UUID
    var history: Blocks

    var routines: [Routine]

    init(history: Blocks,
         routines: [Routine] = [])
    {
        self.id = UUID()
        self.history = history
        self.routines = routines
    }
}
