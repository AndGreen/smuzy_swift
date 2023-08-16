//
//  settings_view.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
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
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
