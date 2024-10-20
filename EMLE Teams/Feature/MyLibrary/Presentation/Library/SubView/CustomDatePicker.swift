//
//  CustomDatePicker.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import SwiftUI

import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDateString: String
    @Binding var isVisible: Bool
    let dateFormat: String = "MMM d, yyyy, h:mm a"

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }

    @State private var selectedDate: Date = Date()

    private func updateDateFromString() {
        if let date = dateFormatter.date(from: selectedDateString) {
            selectedDate = date
        }
    }

    var body: some View {
        if isVisible {
            DatePicker(
                "",
                selection: $selectedDate,
                in: Date()...,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .frame(maxHeight: 400)
            .padding()
            .onAppear(perform: updateDateFromString)
            .onChange(of: selectedDate) { newValue in
                selectedDateString = dateFormatter.string(from: newValue)
            }
        }
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    @State static var previewDate: String = "Sep 3, 2023, 5:00 PM"
    @State static var isVisible: Bool = true

    static var previews: some View {
        CustomDatePicker(selectedDateString: $previewDate, isVisible: $isVisible)
    }
}
