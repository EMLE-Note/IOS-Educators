//
//  dsds.swift
//  EMLE Teams
//
//  Created by iOSAYed on 09/07/2024.
//

import SwiftUI
import EMLECore

struct PaymentMethodItemView: View {
    let image: Image
    let name: String
    let description: String?
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .center) {
            image
                .resizable()
                .frame(width: 60, height: 60)
                .padding(.leading, 10)
            
            VStack(alignment: .leading,spacing: 0) {
                Text(name)
                    .customStyle(.subheadline, .onSurface)
                
                if let description = description {
                    
                    Text(description)
                        .customStyle(.caption1, .success)
                }
            }
            .padding(.leading, 10)
            
            Spacer()
            
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .customForeground(isSelected ? .primary : .container)
                .padding(.trailing, 10)
        }
        .frame(height: 55)
        .padding()
        .customBackground(.container)
        .customCornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.primaryColor : Color.clear, lineWidth: 2)
        )
    }
}

#Preview {
    PaymentMethodItemView(image:Image(systemName: "home"), name: "paymob", description: "save 20%", isSelected: true)
}
