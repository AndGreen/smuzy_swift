import SwiftUI

struct AppView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            DayScreen()
                .tabItem {
                    Image(systemName: "calendar")
                }

            ProfileScreen()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
        .onAppear {
            initState()
        }
    }

    func initState() {
        if appState.routines.isEmpty {
            appState.routines = defaultRoutines
        }
    }
}

#Preview {
    AppView()
        .environmentObject(AppState())
}
