import AlertToast
import SwiftData
import SwiftUI

struct DayScreen: View {
    @State private var isToastOpen = false
    @State private var isCalendarOpen = false
    @State private var selectedDate = Date()

    @Environment(AppState.self) var appState
    @Environment(\.colorScheme) var colorScheme

    @Query var routines: [Routine]
    @Environment(\.modelContext) private var modelContext

    private var arrowIcon: String {
        return isCalendarOpen ? "chevron.up" : "chevron.down"
    }

    var body: some View {
        NavigationView {
            VStack {
                DayGridView()
                    .padding()
                    .background(colorScheme == .dark ? bgDark : bgLight)
                    .clipped()
                RoutinesListView()
                Spacer()
            }
            .background(Color("Background"))
            .navigationBarTitleDisplayMode(.inline)
            .dayViewToolbar(isCalendarOpen: $isCalendarOpen,
                            selectedDate: $selectedDate)
            .onChange(of: appState.selectedDate) {
                withAnimation {
                    if selectedDate != appState.selectedDate {
                        selectedDate = appState.selectedDate
                    }
                }
            }
            .onChange(of: selectedDate) { _, newValue in
                appState.selectedDate = newValue
            }
        }
        .sheet(isPresented: $isCalendarOpen) {
            CalendarScreen(selectedDate: $selectedDate)
                .onChange(of: selectedDate) { _, _ in
                    isCalendarOpen = false
                }
        }
        .toast(isPresenting: $isToastOpen) {
            AlertToast(displayMode: .hud, type: .complete(.green), title: "Cleared")
        }
    }
}

extension View {
    func dayViewToolbar(
        isCalendarOpen: Binding<Bool>,
        selectedDate: Binding<Date>
    ) -> some View {
        toolbar {
            ToolbarItem(placement: .principal) {
                Button(
                    action: {
                        isCalendarOpen.wrappedValue.toggle()
                    }) {
                        HStack {
                            Text(selectedDate.wrappedValue.getFormattedDayLabel())
                            Image(systemName: isCalendarOpen.wrappedValue ? "chevron.up" : "chevron.down")
                                .resizable()
                                .frame(width: 12, height: 7)
                                .offset(x: 0, y: 1)
                        }
                    }
            }
        }
    }
}

#Preview {
    DayScreen()
        .environment(AppState())
        .modelContainer(for: Routine.self)
}
