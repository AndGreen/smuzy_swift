import SwiftData
import SwiftUI

struct RoutineFormView: View {
    enum FocusedField {
        case title
    }

    @Environment(\.modelContext) private var modelContext
    @Query var routines: [Routine]
    @State private var title: String = ""
    @State private var activeColor: Color?
    @Binding var isRoutineFormOpened: Bool
    @Binding var routine: Routine?
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
                    if routine != nil {
                        activeColor = Color.fromHex(routine!.color)
                        title = routine!.title
                    }
                }
                .navigationTitle(routine != nil ? "Edit Routine" : "New Routine")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                    Button("Save") {
                        if routine == nil {
                            let newRoutines = Routine(color: activeColor!.toHex, title: title)

                            modelContext.insert(newRoutines)
                        } else {
                            routine!.color = activeColor!.toHex
                            routine!.title = title
                        }
                        isRoutineFormOpened = false
                    }
                    .disabled(isSaveButtonDisabled)
                )
            }
        }
    }

    func isUsed(color: Color) -> Bool {
        let colorList =
            routines
                .map { routine in
                    routine.color
                }
                .filter { $0 != routine?.color }

        return colorList.contains { $0 == color.toHex }
    }
}

struct RoutineFormViewPreview: View {
    @State var isRoutineFormOpened = false
    var isEdit: Bool = false
    @Query var routines: [Routine]
    @State var editRoutine: Routine?

    var body: some View {
        RoutineFormView(isRoutineFormOpened: $isRoutineFormOpened, routine: $editRoutine)
            .environment(AppState())
            .onAppear {
                if isEdit {
                    editRoutine = routines[0]
                }
            }
    }
}

struct RoutineContainer: View {
    var isEdit: Bool = false

    var body: some View {
        RoutineFormViewPreview(isEdit: isEdit)
            .modelContainer(for: Routine.self)
    }
}

#Preview("New") {
    RoutineContainer()
}

#Preview("Edit") {
    RoutineContainer(isEdit: true)
}
