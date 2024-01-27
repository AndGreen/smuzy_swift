import SwiftData
import SwiftUI

struct RoutinesListView: View {
    @Environment(AppState.self) var appState
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .bouncy(extraBounce: 0.1)) var routines: [Routine]
    @State var editRoutine: Routine?
    @State private var isRoutineFormOpened = false

    var body: some View {
        ScrollView {
            WrappingHStack(alignment: .leading) {
                ForEach(routines) { routine in
                    let isActive = appState.selectedRoutine == routine
                    RoutineButtonView(routine: routine, isActive: isActive, action: {
                        appState.selectedRoutine = isActive ? nil : routine
                    }, onEdit: {
                        editRoutine = routine
                        isRoutineFormOpened = true
                    }, onDelete: {
                        modelContext.delete(routine)
                    })
                }
                AddRoutineButton {
                    $isRoutineFormOpened.wrappedValue.toggle()
                }
            }
            .sheet(isPresented: $isRoutineFormOpened) {
                RoutineFormView(isRoutineFormOpened: $isRoutineFormOpened, routine: $editRoutine)
            }
            .onChange(of: isRoutineFormOpened) { _, isOpened in
                if isOpened == false {
                    editRoutine = nil
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    RoutinesListView()
        .modelContainer(for: Routine.self)
        .environment(AppState())
}
