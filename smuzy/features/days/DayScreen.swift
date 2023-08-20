//
//  ContentView.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct DayScreen: View {
    @State private var isCalendarOpen = false
    @State private var selectedDate = Date()

    @EnvironmentObject var appState: AppState

    private var arrowIcon: String {
        return isCalendarOpen ? "chevron.up" : "chevron.down"
    }

    var body: some View {
        NavigationView {
            VStack {
                DayGridView()
                    .padding()
                    .background(.gray.opacity(0.05))
                    .clipped()
                RoutinesListView()
                Spacer()
            }
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
                    .sheet(isPresented: isCalendarOpen) {
                        CalendarScreen(selectedDate: selectedDate)
                            .onChange(of: selectedDate.wrappedValue) { _, _ in
                                isCalendarOpen.wrappedValue = false
                            }
                    }
            }
        }
    }
}

#Preview {
    DayScreen()
        .environmentObject(AppState(
            routines: defaultRoutines
        ))
}
