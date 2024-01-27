import AlertToast
import SwiftData
import SwiftUI

struct DayScreen: View {
    @State private var isCalendarOpen = false
    @State private var selectedDate = Date()

    @Environment(AppState.self) var appState
    @Environment(\.colorScheme) var colorScheme

    @Query var routines: [Routine]

    private var arrowIcon: String {
        return isCalendarOpen ? "chevron.up" : "chevron.down"
    }
    
    @State private var currentIndex = 0
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Button(
                    action: {
                        isCalendarOpen.toggle()
                    }) {
                        HStack {
                            Text(selectedDate.getFormattedDayLabel())
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            Image(systemName: $isCalendarOpen.wrappedValue ? "chevron.up" : "chevron.down")
                                .resizable()
                                .frame(width: 12, height: 7)
                                .offset(x: 0, y: 1)
                        }

                        .padding(.horizontal, 30)
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                    }
                DayGridView()
                .padding(.bottom, 7)
                .onChange(of: currentIndex) { oldState, newState  in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        let calendar = Calendar.current
                        let selectedDate = appState.selectedDate
                        if currentIndex == 0 {
                            appState.selectedDate = calendar.date(byAdding: .day, value: -1, to: selectedDate)!
                        }
                        if currentIndex == 2 {
                            appState.selectedDate = calendar.date(byAdding: .day, value: 1, to: selectedDate)!
                        }
                        currentIndex = 1
                    }
                    
                }
                RoutinesListView()
            }
            .background(Color("Background"))
            .navigationBarTitleDisplayMode(.inline)
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
    }
}

#Preview {
    DayScreen()
        .environment(AppState())
        .modelContainer(for: Routine.self)
}
