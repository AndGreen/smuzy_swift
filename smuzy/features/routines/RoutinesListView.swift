//
//  RoutinesListView.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct RoutinesListView: View {
    @EnvironmentObject var appState: AppState
    @State private var isRoutineFormOpened = false

    var body: some View {
        WrappingHStack(alignment: .leading) {
            ForEach(appState.routines) { routine in
                let isActive = appState.activeRoutine == routine
                RoutineButtonView(routine: routine, isActive: isActive) {
                    appState.updateActiveRoutine(routine: isActive ? nil : routine)
                }
            }
            AddRoutineButton {
                $isRoutineFormOpened.wrappedValue.toggle()
            }
        }
        .sheet(isPresented: $isRoutineFormOpened) {
            RoutineFormView()
        }
    }
}

struct RoutinesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinesListView()
            .environmentObject(AppState())
    }
}
