//
//  FocusEffectModifier.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/07/2024.
//

import SwiftUI

struct FocusEffectModifier: ViewModifier {
    @Binding var isFocused: Bool
    var cornerRadius: CGFloat
    var primaryColor: Color
    var neutralColor: Color
    var lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(isFocused ? primaryColor : neutralColor, lineWidth: lineWidth)
                    .scaleEffect(isFocused ? 1.02 : 1)
                    .animation(.easeOut(duration: 0.2), value: isFocused)
            )
    }
}
