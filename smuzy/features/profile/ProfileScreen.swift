import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

        NavigationView {
            List {
                Section {
                    Button(action: {
                        print("Backup to File")
                    }) {
                        Text("Backup to File")
                    }

                    Button(action: {
                        print("Restore from Backup")
                    }) {
                        Text("Restore from Backup")
                    }
                }

                Text("App version " + (appVersion ?? ""))
                    .frame(
                        maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.gray.opacity(0.3))
                    .listRowBackground(Color.clear)
            }
            .background(Color("Background"))
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsScreen()
}
