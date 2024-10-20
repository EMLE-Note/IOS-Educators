//
//  CustomCheckBox.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/07/2024.
//

import EMLECore
import SwiftUI

struct CustomCheckbox: View {
    let title: String
    @Binding var isChecked: Bool
    let action: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: .xSm) {
            Button(action: {
                self.action()
                self.isChecked.toggle()
            }) {
                HStack(alignment: .center) {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: .xBig, height: .xBig)
                        .customForeground(self.isChecked ? .primary : .neutral)
                }
            }
            Text(title)
                .customStyle(.bodySmall, .onSurface)
        }
      
    }
}

#Preview {
    CustomCheckbox(title: "Request activation", isChecked: .constant(false), action: {})
}
