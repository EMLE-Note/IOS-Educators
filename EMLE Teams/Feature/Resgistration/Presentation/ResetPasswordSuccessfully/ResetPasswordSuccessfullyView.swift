//
//  ResetPasswordSuccessfullyView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 29/04/2024.
//

import SwiftUI
import EMLECore

struct ResetPasswordSuccessfullyView: View {
    
    @StateObject var viewModel: ResetPasswordSuccessfullyViewModel
    
    init(coordinator: ResetPasswordSuccessfullyCoordinating) {
        _viewModel = StateObject(wrappedValue: ResetPasswordSuccessfullyViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 24) {
                
                success
                
                yourAccountHasBeenSuccessfullyCreated
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var success: some View {
        Image.success
            .resizable()
            .frame(width: 88, height: 88)
    }
    
    private var yourAccountHasBeenSuccessfullyCreated: some View {
        Text(RegistrationStrings.yourAccountHasBeenSuccessfullyCreated.localized)
            .customFont(size: 36, weight: ._500, lineHeight: 41)
            .customForeground(.onSurface)
    }
}

#Preview {
    ResetPasswordSuccessfullyView(coordinator: ResetPasswordSuccessfullyCoordinator(navigationController: UINavigationController()))
}
