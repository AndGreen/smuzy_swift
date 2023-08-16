//
//  CalendarView.swift
//  smuzy
//
//  Created by Andrey Zelenin on 12.08.2023.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date

    var body: some View {
        ScrollView {
            VStack {
                DatePicker(
                    "Select a date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .navigationBarTitle("Pick date")
                .navigationBarTitleDisplayMode(.inline)

                Button(action: {
                    $selectedDate.wrappedValue = Date()
                }) {
                    Text("Today")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .scrollDisabled(true)
        .padding()
    }
}

#Preview {
    let selectedDate = Binding<Date>(
        get: { Date() },
        set: { _ in }
    )

    return CalendarView(selectedDate: selectedDate)
}
