//
//  RoutineFormView.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct RoutineFormView: View {
    @EnvironmentObject var appState: AppState
    @State private var textInput: String = ""

    var colorList: [Color] {
        return appState.colors.map { $0.value }
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Title", text: $textInput)

                    HStack {
                        Spacer()
                        WrappingHStack(alignment: .leading,
                                       horizontalSpacing: 8, verticalSpacing: 20)
                        {
                            ForEach(colorList.indices, id: \.self) { colorName in
                                CircleButton(color: colorList[colorName]) {}
                            }
                        }.padding(.vertical)
                        Spacer()
                    }
                }
                .navigationTitle("New Routine")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                    Button("Save") {
                        // Handle save action here
                        print("Saving: \(textInput)")
                    }
                )
            }
        }
    }
}

struct CircleButton: View {
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
        }
    }
}

struct RoutineFormView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineFormView()
            .environmentObject(AppState())
    }
}
