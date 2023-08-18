import SwiftData
import SwiftUI

struct AppView: View {
    @Query var users: [UserModel]
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            DayView()
                .tabItem {
                    Image(systemName: "calendar")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
        .onChange(of: appState.dayGrid) {
            print(appState.dayGrid)
        }
        .onAppear(perform: {
            let defaultRoutines = [
                Routine(color: Color.blue.toHex, title: "media"),
                Routine(color: Color.green.toHex, title: "sleep"),
                Routine(color: Color.orange.toHex, title: "work"),
                Routine(color: Color.gray.toHex, title: "sport"),
                Routine(color: Color.yellow.toHex, title: "eat")
            ]

            let newUser = UserModel(history: [:], routines: defaultRoutines)

            if users.count == 0 {
                modelContext.insert(newUser)
                appState.user = User(history: newUser.history, routines: newUser.routines)
            } else {
                appState.user = User(history: users[0].history, routines: users[0].routines)
            }

            if appState.routines.isEmpty {
//                appState.routines = defaultRoutines
            }

            print(appState.user.routines)
        })
    }
}

#Preview {
    AppView()
        .environmentObject(AppState())
        .modelContainer(for: [Routine.self, UserModel.self], inMemory: true)
}
