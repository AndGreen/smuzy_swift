import SwiftData
import SwiftUI

@main
struct smuzyApp: App {
    var body: some Scene {
        WindowGroup {
            SplashCoordinator()
        }
    }

    func initNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance =
            UINavigationBar.appearance().standardAppearance
    }
}

struct SplashCoordinator: View {
    @State private var isActive = false
    @State var appState = AppState()

    var body: some View {
        if isActive {
            AppView()
                .environment(appState)
                .modelContainer(for: [Routine.self, Block.self])
        } else {
            SplashScreen(isActive: $isActive)
        }
    }
}
