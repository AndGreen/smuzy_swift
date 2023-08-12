//
//  RoutineModel.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import Foundation
import SwiftUI

struct Routine: Identifiable, Hashable {
    var id = UUID()
    var color: Color
    var title: String
}
