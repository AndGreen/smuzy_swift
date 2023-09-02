import SwiftUI

struct RoutinesListView: View {
    @Environment(AppState.self) var appState
    @State private var isRoutineFormOpened = false

    var body: some View {
        ScrollView {
            WrappingHStack(alignment: .leading) {
                ForEach(appState.routines) { routine in
                    let isActive = appState.selectedRoutine == routine
                    RoutineButtonView(routine: routine, isActive: isActive, action: {
                        appState.selectedRoutine = isActive ? nil : routine
                    }, onEdit: {}, onDelete: {
                        withAnimation {
                            appState.routines = appState.routines.filter { $0.id != routine.id }
                        }
                    })
                }
                AddRoutineButton {
                    $isRoutineFormOpened.wrappedValue.toggle()
                }
            }
            .sheet(isPresented: $isRoutineFormOpened) {
                RoutineFormView(isRoutineFormOpened: $isRoutineFormOpened)
            }
            .padding(.top, 3)
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    RoutinesListView()
        .environment(AppState(routines: defaultRoutines))
}
