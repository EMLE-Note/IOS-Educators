//
//  PopupSheetView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/07/2024.
//

import Foundation
import SwiftUI

struct PopupSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    @Binding var isLoading: Bool
    var onDismiss: () -> Void
    let content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            PopupSheetTopView()
            content()
                .customBackground(.primary)
        }
        .onTapGesture {
            dismissKeyboard()
        }
        .overlay {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }

    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func popupSheet<Content: View>(
        isPresented: Binding<Bool>,
        isLoading: Binding<Bool> = .constant(false),
        onDismiss: @escaping () -> Void = {},
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        PopupSheetView(isPresented: isPresented, isLoading: isLoading, onDismiss: onDismiss, content: content)
    }
}
