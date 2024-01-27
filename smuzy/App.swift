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

            ProgressView()
                .tabItem {
                    Label("Progress", systemImage: "chart.pie.fill")
                }

            SettingsScreen()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .onChange(of: appState.selectedDate) { _, _ in
            loadDayGrid()
        }
        .onAppear {
            if routines.isEmpty {
                defaultRoutines.forEach { modelContext.insert($0) }
            }
            loadDayGrid()
        }
    }

    func loadDayGrid() {
        appState.dayGrid = Block.loadDayGrid(date: appState.selectedDate, modelContext: modelContext)
    }
}

#Preview {
    AppView()
        .environment(AppState())
        .modelContainer(for: [Routine.self, Block.self])
}
