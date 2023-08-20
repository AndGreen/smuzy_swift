//
//  RoutineModel.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import Foundation
import SwiftUI

class Routine: Hashable, Identifiable, Equatable {
    var id: RoutineId
    var color: String
    var title: String

    init(color: String, title: String) {
        self.id = UUID()
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

extension [Routine] {
    var colorMap: [RoutineId: Color] {
        return self.reduce(into: [:]) { result, routine in
            result[routine.id] = Color.fromHex(routine.color)
        }
    }
}
