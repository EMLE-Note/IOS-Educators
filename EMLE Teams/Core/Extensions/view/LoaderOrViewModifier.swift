//
//  LoaderOrViewModifier.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/07/2024.
//

import SwiftUI
import EMLECore

struct LoaderOrViewModifier: ViewModifier {

    var maxHeight: CGFloat = .infinity
    var maxWidth: CGFloat = .infinity
    
    @Binding var isLoading: LoadingState

    func body(content: Content) -> some View {
        if isLoading == .loading {
            ProgressView()
                .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        } else {
            content
        }
    }
}

extension View {

    func withLoaderOrView(maxHeight: CGFloat = .infinity, maxWidth: CGFloat = .infinity, isLoading: Binding<LoadingState>) -> some View {
        modifier(
            LoaderOrViewModifier(maxHeight: maxHeight, isLoading: isLoading)
        )
    }
}
