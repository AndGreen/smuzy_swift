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
            DatePicker(
                "Select a date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .navigationBarTitle("Pick date")
            .navigationBarTitleDisplayMode(.inline)
        }
        .scrollDisabled(true)
        .padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let selectedDate = Binding<Date>(
            get: { Date() },
            set: { _ in }
        )

        return CalendarView(selectedDate: selectedDate)
    }
}
