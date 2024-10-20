//
//  SymbolButton.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 04/10/2024.
//

import SwiftUI

struct SymbolButton: View {
    let image: Image  // Change to use an Image directly
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
        }
//        .buttonStyle(CustomStyle())
    }
}

struct CustomStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .background(Color.purple.opacity(configuration.isPressed ? 0.4 : 1))
            .clipShape(Circle())
            .foregroundStyle(.white)
    }
}
