//
//  View+CustomNavigationBarStyle.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//

import SwiftUI

struct CustomNavigationBarStyleModifier: ViewModifier {
    
    let bottomPadding: CGFloat
    let horizontalPadding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, bottomPadding)
            .padding(.horizontal, horizontalPadding)
    }
}

extension View {
    func addCustomNavigationBarStyle(bottomPadding: CGFloat = 8, horizontalPadding: CGFloat = 16) -> some View {
        ModifiedContent(content: self, modifier: CustomNavigationBarStyleModifier(bottomPadding: bottomPadding,
                                                                                  horizontalPadding: horizontalPadding))
    }
}
