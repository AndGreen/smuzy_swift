import SwiftData
import SwiftUI

struct AppView: View {
    @Query var users: [UserModel]
    @Environment(\.modelContext) private var modelContext
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
            restoreState()
        }
        .onChange(of: appState.routines) { _, newRoutines in
            let user = users.first
            if user != nil &&
                !newRoutines.isEmpty &&
                newRoutines != user!.routines.data
            {
                let newUser =
                    UserModel(history: user!.history, routines: newRoutines.model)

                updateUser(
                    user: user!,
                    newUser: newUser
                )
            }
        }
    }

    func updateUser(user: UserModel, newUser: UserModel) {
        modelContext.delete(user)
        modelContext.insert(newUser)
    }

    func restoreState() {
        let user = users.first
        if user == nil {
            modelContext.insert(UserModel(
                history: [:],
                routines: defaultRoutines.model
            ))
        }
        if user != nil {
            appState.routines = user!.routines.data
        }
    }
}

#Preview {
    AppView()
        .environmentObject(AppState())
        .modelContainer(for: [RoutineModel.self, UserModel.self])
}
