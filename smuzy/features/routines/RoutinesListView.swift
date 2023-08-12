//
//  RoutinesListView.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct RoutinesListView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        WrappingHStack(alignment: .leading) {
            ForEach(appState.routines) { routine in
                RoutineButtonView(routine: routine)
            }
            AddRoutineButton()
        }
    }
}

struct RoutinesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinesListView()
            .environmentObject(AppState())
    }
}
