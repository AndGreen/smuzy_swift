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

            Text("Coming soon 🏗️")
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }

            ProfileScreen()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .onAppear {
            if routines.isEmpty {
                defaultRoutines.forEach { modelContext.insert($0) }
            }
        }
    }
}

#Preview {
    AppView()
        .environment(AppState())
        .modelContainer(for: [Routine.self, Block.self])
}
