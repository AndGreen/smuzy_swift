import SwiftData
import SwiftUI

struct RoutinesListView: View {
    @EnvironmentObject var appState: AppState
    @State private var isRoutineFormOpened = false

    var body: some View {
        ScrollView {
            WrappingHStack(alignment: .leading) {
                ForEach(appState.routines) { routine in
                    let isActive = appState.selectedRoutine == routine
                    RoutineButtonView(routine: routine, isActive: isActive) {
                        appState.selectedRoutine = isActive ? nil : routine
                    }
                }
                AddRoutineButton {
                    $isRoutineFormOpened.wrappedValue.toggle()
                }
            }
            .sheet(isPresented: $isRoutineFormOpened) {
                RoutineFormView(isRoutineFormOpened: $isRoutineFormOpened)
            }
        }
    }
}

#Preview {
    RoutinesListView()
        .environmentObject(AppState())
        .modelContainer(for: Routine.self)
}
