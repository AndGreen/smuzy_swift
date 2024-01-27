import SwiftData
import SwiftUI

struct AppView: View {
    @Query var routines: [Routine]
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) var appState

    var body: some View {
        TabView {
            DayScreen()
                .tabItem {
                    Label("Home", systemImage: "calendar")
                }

//            ProgressView()
//                .tabItem {
//                    Label("Progress", systemImage: "chart.pie.fill")
//                }

            SettingsScreen()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .onChange(of: appState.selectedDate) { _, _ in
            appState.loadDayGrid(modelContext: modelContext)
        }
        .onAppear {
            if routines.isEmpty {
                defaultRoutines.forEach { modelContext.insert($0) }
            }
            appState.loadDayGrid(modelContext: modelContext)
        }
    }
}

#Preview {
    AppView()
        .environment(AppState())
        .modelContainer(for: [Routine.self, Block.self])
}
