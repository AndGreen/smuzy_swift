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
                    Image(systemName: "calendar").symbolEffect(.pulse)
                }

            ProfileScreen()
                .tabItem {
                    Image(systemName: "person.fill").symbolEffect(.pulse)
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
