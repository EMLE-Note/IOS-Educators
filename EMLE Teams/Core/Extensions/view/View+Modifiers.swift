//
//  ds.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/07/2024.
//

import SwiftUI

extension View {
    func focusEffect(isFocused: Binding<Bool>, cornerRadius: CGFloat, primaryColor: Color, neutralColor: Color, lineWidth: CGFloat = 2) -> some View {
        modifier(FocusEffectModifier(isFocused: isFocused, cornerRadius: cornerRadius, primaryColor: primaryColor, neutralColor: neutralColor, lineWidth: lineWidth))
    }
}
