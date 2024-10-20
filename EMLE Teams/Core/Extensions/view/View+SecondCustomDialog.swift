//
//  View+SecondCustomDialog.swift
//  EMLE Teams
//
//  Created by iOSAYed on 10/08/2024.
//

import Foundation
import SwiftUI
import EMLECore

public extension View {
    
    func withSecondCustomDialog(isPresented: Binding<Bool>,
                          image: Image,
                          title: String,
                          message: String,
                          yesButtonTitle: String,
                          yesButtonAction: EmptyAction,
                          noButtonTitle: String) -> some View {
        withCustomOverlayContent(isPresented: isPresented) {
            
            SecondCustomDialog(isPresent: isPresented, title: title, message: message, yesButtonTitle: yesButtonTitle, noButtonTitle: noButtonTitle, yesAction: yesButtonAction)
            .padding(.horizontal, 16)
        }
    }
}
