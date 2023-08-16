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
class Routine {
    var id: RoutineId
    var color: String
    var title: String

    init(color: String, title: String) {
        self.id = UUID()
        self.color = color
        self.title = title
    }
}

extension [Routine] {
    var routinesColorMap: [RoutineId: Color] {
        return self.reduce(into: [:]) { result, routine in
            result[routine.id] = Color.fromHex(routine.color)
        }
    }
}
