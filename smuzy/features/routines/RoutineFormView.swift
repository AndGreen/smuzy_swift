import SwiftUI

struct RoutineFormView: View {
    enum FocusedField {
        case title
    }

    @EnvironmentObject var appState: AppState
    @State private var title: String = ""
    @State private var activeColor: Color?
    @Binding var isRoutineFormOpened: Bool
    @FocusState private var focusedField: FocusedField?

    var colorList: [Color] {
        let colorOrder: [String] = [
            "red", "pink", "purple", "deepPurple", "indigo",
            "blue", "cyan", "teal", "green", "lightGreen",
            "yellow", "orange", "brown", "gray", "blueGray", "black"
        ]

        return colorOrder.compactMap { colorName in
            defaultColors[colorName]
        }
    }

    var isSaveButtonDisabled: Bool {
        title.isEmpty || activeColor == nil
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Title", text: $title)
                        .focused($focusedField, equals: .title)
                    HStack {
                        Spacer()
                        WrappingHStack(alignment: .center,
                                       horizontalSpacing: 15, verticalSpacing: 20)
                        {
                            ForEach(colorList.indices, id: \.self) { colorName in
                                let isActive =
                                    activeColor == colorList[colorName]
                                CircleColorButton(
                                    color: colorList[colorName],
                                    onTap: { color in
                                        activeColor = isActive ? nil : color
                                    },
                                    isActive: isActive, isUsed: isUsed(color: colorList[colorName]))
                            }
                        }.padding(.vertical)
                        Spacer()
                    }
                }
                .onAppear {
                    focusedField = .title
                }
                .navigationTitle("New Routine")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                    Button("Save") {
                        appState.routines.append(Routine(color: activeColor!.toHex, title: title))
                        isRoutineFormOpened = false
                    }
                    .disabled(isSaveButtonDisabled)
                )
            }
        }
    }

    func isUsed(color: Color) -> Bool {
        let colorList = appState.routines.map { routine in
            routine.color
        }
        print(colorList)
        return colorList.contains { $0 == color.toHex }
    }
}

struct RoutineFormView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isRoutineFormOpened = false
        RoutineFormView(isRoutineFormOpened: $isRoutineFormOpened)
            .environmentObject(AppState())
    }
}
