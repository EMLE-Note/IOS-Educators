//
//  ds.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/07/2024.
//

import Foundation

import SwiftUI

struct DismissingKeyboardModifier: ViewModifier {

    @Binding var isFocusedOne: Bool
    @Binding var isFocusedTwo: Bool

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                isFocusedOne = false
                isFocusedTwo = false
            }
    }
}

extension View {

    func dismissKeyboardOnTap(isFocused: Binding<Bool>) -> some View {
        modifier(
            DismissingKeyboardModifier(
                isFocusedOne: isFocused,
                isFocusedTwo: .constant(false)
            )
        )
    }

    func dismissKeyboardOnTap(
        isFocusedOne: Binding<Bool> = .constant(false),
        isFocusedTwo: Binding<Bool> = .constant(false)
    ) -> some View {
        modifier(
            DismissingKeyboardModifier(
                isFocusedOne: isFocusedOne,
                isFocusedTwo: isFocusedTwo
            )
        )
    }
}
