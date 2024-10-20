//
//  sd.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/07/2024.
//

import Foundation
import SwiftUI
import EMLECore

struct LoaderOnTopOfViewModifier: ViewModifier {

    @Binding var isLoading: LoadingState

    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading == .loading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

extension View {

    func withLoaderOnTopOfView(isLoading: Binding<LoadingState>) -> some View {
        modifier(
            LoaderOnTopOfViewModifier(isLoading: isLoading)
        )
    }
}
