//
//  CongratsView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import SwiftUI
import EMLECore

struct CongratsView: View {
    
    @StateObject var viewModel: CongratsViewModel
    
    init(coordinator: CongratsCoordinating) {
        _viewModel = StateObject(wrappedValue: CongratsViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                
                VStack(spacing: 32) {
                    
                    image
                    
                    congrats
                    
                    yourAccountHasBeenSuccessfullyCreated
                    
                    startLearning
                }
                .padding(16)
                
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var image: some View {
        Image.createAccountSuccess
            .resizable()
            .frame(width: 230, height: 230)
    }
    
    private var congrats: some View {
        Text(RegistrationStrings.congrats.localized)
            .customFont(size: 22, weight: ._300, lineHeight: 34)
            .customForeground(.subtitle)
    }
    
    private var yourAccountHasBeenSuccessfullyCreated: some View {
        Text(RegistrationStrings.yourAccountHasBeenSuccessfullyCreated.localized)
            .customFont(size: 28, weight: ._500, lineHeight: 34)
            .customForeground(.onSurface)
    }
    
    private var startLearning: some View {
        PrimaryButton(title: RegistrationStrings.startLearning.localized,
                      action: viewModel.onStartLearningClick)
    }
}

#Preview {
    CongratsView(coordinator: CongratsCoordinator(navigationController: UINavigationController()))
}
