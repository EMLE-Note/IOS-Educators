//
//  CustomRadioButton.swift
//  EMLE Teams
//
//  Created by iOSAYed on 26/07/2024.
//

import SwiftUI
import EMLECore

struct CustomRadioButton: View {
    let title: String
    let description: String?
    let isSelected: Bool
    let action: () -> Void

    // Existing initializer without description
    init(title: String, isSelected: Bool, action: @escaping () -> Void) {
        self.title = title
        self.description = nil
        self.isSelected = isSelected
        self.action = action
    }

    // New initializer with optional description
    init(title: String, description: String?, isSelected: Bool, action: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.isSelected = isSelected
        self.action = action
    }

    var body: some View {
        HStack(alignment: .center, spacing: .xSm) {
            Button(action: self.action) {
                HStack(alignment: .center) {
                    Image(systemName: self.isSelected ? "largecircle.fill.circle" : "circle")
                        .resizable()
                        .frame(width: .big, height: .big)
                        .customForeground(self.isSelected ? .primary : .neutral)
                }
            }
            VStack(alignment: .leading) {
                Text(title)
                    .customStyle(.bodySmall, .onSurface)
                if let desc = description {
                    Text(desc)
                        .customStyle(.caption2, .subtitle)
                }
            }
        }
        .customBackground(.container)
    }
}

// Preview
struct CustomRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomRadioButton(title: "Latest", isSelected: true, action: {})
    }
}
