import SwiftUI

extension Bundle {
    var releaseVersionNumber: String {
        return (infoDictionary?["CFBundleShortVersionString"] ?? "") as! String
    }

    var buildVersionNumber: String {
        return (infoDictionary?["CFBundleVersion"] ?? "") as! String
    }
}

struct SettingsScreen: View {
    var body: some View {
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

                Text("App version \(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))")
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
