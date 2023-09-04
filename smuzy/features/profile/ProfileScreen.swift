//
//  settings_view.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct ProfileScreen: View {
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
                    .foregroundColor(.gray.opacity(0.5))
                    .listRowBackground(Color.clear)
            }
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileScreen()
}
