//
//  CustomLayerView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 22/08/2024.
//

import SwiftUI
import EMLECore

struct CustomLayerView: View {
    let title: String
    let placeholder: String
    @Binding var value: String
    let onClick: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .customStyle(.bodySmall, .onSurface)
                .padding()
            
            Spacer()
            
            CustomTextField(
                placeholder: placeholder,
                value: $value,
                borderStateColor: .neutral,
                disable: true
            )
            .frame(width: 150, height: 40)
            .padding(.sm)
            .onTapGesture {
                onClick()
            }
        }
    }
}

struct CustomLayerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLayerView(
            title: "Font size",
            placeholder: "16",
            value: .constant("16"),
            onClick: {
                // Handle tap action for preview purposes
                print("Font size clicked")
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

