//
//  View+CustomDialog.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation
import SwiftUI
import EMLECore

public extension View {
    func withCustomDialog(isPresented: Binding<Bool>,
                                image: Image,
                                title: String,
                                message: String,
                                yesButtonTitle: String,
                                yesButtonAction: EmptyAction,
                                noButtonTitle: String) -> some View {
        withCustomOverlayContent(isPresented: isPresented) {
            CustomDialogView(isPresent: isPresented, title: title, message: message, yesButtonTitle: yesButtonTitle, noButtonTitle: noButtonTitle, yesAction: yesButtonAction)
                .padding(.horizontal, .md)
        }
    }
    
    func withDialog(isPresented: Binding<Bool>,
                    title: String,
                    message: String) -> some View {
        withCustomOverlayContent(isPresented: isPresented) {
            AboutDialogView(isPresent: isPresented, title: title, message: message)
                .padding(.horizontal, .md)
        }
    }
    
    func withContentDialog<DialogContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> DialogContent
    ) -> some View {
        ZStack {
            withCustomOverlayContent(isPresented: isPresented) {
                ContentDialogView(isPresent: isPresented, content: content())
                    .padding(.horizontal, .xxSm)
            }
        }
    }
}
