import SwiftData
import SwiftUI

struct AppView: View {
    @Query var users: [UserModel]
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
        .onChange(of: appState.routines) { oldRoutines, newRoutines in
            var user = users.first

            let addedRoutines = newRoutines.filter { !oldRoutines.contains($0) }
            let removedRoutines = oldRoutines.filter { !newRoutines.contains($0) }

            if user != nil &&
                !oldRoutines.isEmpty
            {
                if !addedRoutines.isEmpty {
                    user!.routines = addedRoutines.model
                }
                if !removedRoutines.isEmpty {
                    user!.routines = user!.routines.data.filter { !removedRoutines.contains($0) }.model
                }
            }
        }
        .onAppear {
            restoreState()
        }
    }

    func updateUser(user: UserModel, newUser: UserModel) {
        modelContext.delete(user)
        modelContext.insert(newUser)
    }

    func restoreState() {
        let user = users.first
        print(users.count)
        if users.isEmpty {
            print("INSERT")
            modelContext.insert(UserModel(
                history: [:],
                routines: defaultRoutines.model
            ))
        } else {
            print("USER ROUTINES COUNT:", user!.routines.count)
            appState.routines = user!.routines.data
        }
    }
}

#Preview {
    AppView()
        .environment(AppState())
        .modelContainer(for: [RoutineModel.self, UserModel.self])
}
