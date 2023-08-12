//
//  ContentView.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct DayView: View {
    @State private var isCalendarOpen = false
    @EnvironmentObject var appState: AppState
    @State private var selectedDate = Date()

    private var arrowIcon: String {
        return isCalendarOpen ? "chevron.up" : "chevron.down"
    }

    var body: some View {
        NavigationView {
            VStack {
                DayGridView()
                    .background(.gray.opacity(0.05))
                    .clipped()
                RoutinesListView()
                    .padding(.horizontal, 10)
                    .padding(.top, 3)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .dayViewToolbar(isCalendarOpen: $isCalendarOpen,
                            selectedDate: $selectedDate, onDateSelected: { _ in
                                appState.updateSelectedDate(date: $selectedDate.wrappedValue)
                            })
        }
    }
}

extension View {
    func dayViewToolbar(
        isCalendarOpen: Binding<Bool>,
        selectedDate: Binding<Date>,
        onDateSelected: (Date) -> Void
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
                        }
                    }
                    .sheet(isPresented: isCalendarOpen) {
                        CalendarView(selectedDate: selectedDate)
                            .onChange(of: selectedDate.wrappedValue, perform: { _ in
                                isCalendarOpen.wrappedValue = false
                            })
                    }
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
            .environmentObject(AppState())
    }
}
