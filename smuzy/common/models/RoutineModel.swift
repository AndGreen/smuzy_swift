//
//  RoutineModel.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class RoutineModel {
    var id: RoutineId
    var color: String
    var title: String

    init(id: UUID = UUID(), color: String, title: String) {
        self.id = id
        self.color = color
        self.title = title
    }
}

class Routine: Hashable, Identifiable, Equatable {
    var id: RoutineId
    var color: String
    var title: String

    init(id: UUID = UUID(), color: String, title: String) {
        self.id = id
        self.color = color
        self.title = title
    }

    static func == (lhs: Routine, rhs: Routine) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension [RoutineModel] {
    var data: [Routine] {
        return map { routineModel in
            Routine(
                id: routineModel.id,
                color: routineModel.color,
                title: routineModel.title
            )
        }
    }
}

extension [Routine] {
    var colorMap: [RoutineId: Color] {
        return self.reduce(into: [:]) { result, routine in
            result[routine.id] = Color.fromHex(routine.color)
        }
    }

    var model: [RoutineModel] {
        return self.map { routine in
            RoutineModel(
                id: routine.id,
                color: routine.color,
                title: routine.title
            )
        }
    }
}
