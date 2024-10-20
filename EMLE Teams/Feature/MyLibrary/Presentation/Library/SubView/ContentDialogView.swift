//
//  ContentDialogView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/10/2024.
//

import SwiftUI
import EMLECore

struct ContentDialogView<Content: View>: View {
    @Binding var isPresent: Bool
    let content: Content
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.4)
                .onTapGesture {
                    close()
                }
            
            VStack {
                content
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
            .padding(30)
        }
        .ignoresSafeArea()
    }
    
    func close() {
        isPresent = false
    }
}

struct ContentDialogView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDialogView(isPresent: .constant(true), content: exampleContent)
    }
    
    static var exampleContent: some View {
        VStack(spacing: 16) {
            Text("Custom Content")
                .font(.headline)
            
            Text("This is a custom message inside the dialog.")
                .multilineTextAlignment(.center)
            
            Button(action: { print("OK tapped") }) {
                Text("OK")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
