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

    @Relationship(deleteRule: .nullify) var routines: [RoutineModel]

    init(id: UUID = UUID(),
         history: Blocks,
         routines: [RoutineModel] = [])
    {
        self.id = id
        self.history = history
        self.routines = routines
    }
}
