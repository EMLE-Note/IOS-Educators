//
//  StepNavigationButtons.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct StepNavigationButtons<ViewModel>: View where ViewModel: ObservableObject {
    @ObservedObject var viewModel: ViewModel
    let backAction: EmptyAction
    let nextAction: EmptyAction
    let isNextButtonDisabled: Bool
    let isBackButtonDisabled: Bool = false

    var body: some View {
        HStack {
            OutlinedButton(title: "Back",
                           action: backAction,
                           cornerRadius: 24,
                           textColor: .primary,
                           borderColor: .neutral)
            .disabled(isBackButtonDisabled)
            
            Spacer()
            PrimaryButton(title: "Next", action: nextAction)
                .disabled(isNextButtonDisabled)
                .clipShape(Capsule())
        }
        .padding()
    }
}

struct StepButtons<ViewModel>: View where ViewModel: ObservableObject {
    @ObservedObject var viewModel: ViewModel
    let previosAction: EmptyAction
    let nextAction: EmptyAction
    let isNextButtonDisabled: Bool
    let isBackButtonDisabled: Bool

    var body: some View {
        HStack {
            OutlinedButton(title: "Previous",
                           action: previosAction,
                           leadingIcon: Image.backIcon,
                           cornerRadius: 24,
                           textColor: .onSurface,
                           borderColor: .primary)
            .disabled(isBackButtonDisabled)
            
            Spacer()
            PrimaryButton(title: "Next",
                          action: nextAction,
                          trailingIcon: Image.nextIcon)
                .disabled(isNextButtonDisabled)
                .clipShape(Capsule())
        }
        .padding()
    }
}
