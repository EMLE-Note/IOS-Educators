//
//  EditView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 10/08/2024.
//

import SwiftUI
import EMLECore

struct EditView: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .customStyle(.subheadline, .onSurface)
            
            Spacer()
            
            Image.arrow
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.xSm)
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .customBackground(.container)
        .customCornerRadius(.sm)
        .shadow(color: .black.opacity(0.05), radius: 15, x: 0, y: 15)
        .onTapGesture {
            self.action()
        }
    }
}

