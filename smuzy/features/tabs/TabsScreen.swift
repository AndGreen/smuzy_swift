import SwiftUI

struct TabsScreen: View {
    var body: some View {
        TabView {
            DayScreen()
                .tabItem {
                    Label("Home", systemImage: "calendar")
                }
                .tag("Calendar")

//            ProgressView()
//                .tabItem {
//                    Label("Progress", systemImage: "chart.pie.fill")
//                }

            SettingsScreen()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag("Settings")
        }
    }
}
