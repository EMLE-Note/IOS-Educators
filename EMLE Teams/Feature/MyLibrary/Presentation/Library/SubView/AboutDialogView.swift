//
//  AboutDialogView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 22/08/2024.
//

import SwiftUI
import EMLECore

struct AboutDialogView: View {
    @Binding var isPresent: Bool
    
    let title: String
    let message: String
    
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color(.black)
                .opacity(0.4)
                .onTapGesture {
                    close()
                }
            
            VStack(alignment: .leading, spacing: .sm) {
                HStack(spacing: .xxSm) {
                    Image.aboutLayers
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.xSm)
                        .onTapGesture {
                            
                        }
                    Text(title)
                        .customStyle(.heading3, .onSurface)
                }
                
                Text(message)
                    .customStyle(.bodySmall, .subtitle)
                    .multilineTextAlignment(.leading)

            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .customBackground(.container)
            .clipShape(RoundedRectangle(cornerRadius: .md))
            .overlay(alignment: .topTrailing) {
                RoundImageButton(image: Image(systemName: "xmark"),
                                 action: { close() })
                .clipShape(Capsule())
                .padding(.xSm)
            }
            .shadow(radius: 20)
            .padding(.xxBig)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isPresent = false
        }
    }
}

#Preview {
    AboutDialogView(isPresent: .constant(true), title: "Access photos?", message: "This lets you choose which photos you want to add to this project.")
}
