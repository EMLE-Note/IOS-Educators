//
//  secondCustomDialog.swift
//  EMLE Teams
//
//  Created by iOSAYed on 10/08/2024.
//

import SwiftUI
import EMLECore

struct SecondCustomDialog: View {
    @Binding var isPresent: Bool

    let title: String
    let message: String
    let yesButtonTitle: String
    let noButtonTitle: String
    let yesAction: EmptyAction

    
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {

            VStack(alignment:.center,spacing: .sm) {
                Text(title)
                    .customStyle(.heading2, .onSurface)

                Text(message)
                    .customStyle(.bodySmall, .subtitle)
                    .multilineTextAlignment(.center)
                PrimaryButton(title: yesButtonTitle, action: yesAction,backgroundColor: .error)
                    .clipShape(Capsule())
                OutlinedButton(title: noButtonTitle, action: close,cornerRadius: 25, textColor: .subtitle,borderColor:.subtitle)
                
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .customBackground(.container)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(alignment: .topTrailing) {
                Button {
                    close()
                } label: {
                    Image(.closeIcWithBG)
                }
                .tint(.black)
                .padding()
            }
            .shadow(radius: 20)
            .padding(30)
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

struct SecondCustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        SecondCustomDialog(isPresent: .constant(true), title: "Access photos?", message: "This lets you choose which photos you want to add to this project.", yesButtonTitle: "Access photos?", noButtonTitle: "Give Access", yesAction: {})
    }
}
