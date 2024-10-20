//
//  ResetPasswordView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 29/04/2024.
//

import SwiftUI
import EMLECore

struct ResetPasswordView: View {
    @Environment(\.colorScheme) var colorScheme
    
    enum FocusField: Hashable {
        case password, confirmPassword
    }
    
    @FocusState var focusedField: FocusField?
    
    @StateObject var viewModel: ResetPasswordViewModel
    
    init(mobile: String, mobileCode: String, OTP: String, coordinator: ResetPasswordCoordinating) {
        _viewModel = StateObject(wrappedValue: ResetPasswordViewModel(mobileCode: mobileCode, mobile: mobile, OTP: OTP, coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 32) {
                        
                        createPassword
                        
                        VStack(spacing: 16) {
                            newPassword
                            
                            confirmPassword
                        }
                        
                        submit
                        
                        Spacer()
                        
                    }
                }
                .padding(16)
            }
            .onTapGesture { focusedField = nil }
            .navigationBarBackButtonHidden(true)
            .withLoadingState(loadingState: viewModel.loadingState,
                              failureViewClickAction: viewModel.onAppear)
        }
    }
    
    private var tapGesture: some Gesture {
        TapGesture().onEnded {
            focusedField = nil
        }
    }
    
    private var navigationBar: some View {
        HStack {
            BackButton()
            
            Spacer()
        }
        .addCustomNavigationBarStyle(bottomPadding: 16)
    }
    
    private var createPassword: some View {
        Text(RegistrationStrings.createPassword.localized)
            .customFont(size: 36, weight: ._500, lineHeight: 41)
            .customForeground(.onSurface)
    }
    
    private var newPassword: some View {
        CustomSecureField(placeholder: RegistrationStrings.newPassword.localized,
                          value: $viewModel.password,
                          checker: $viewModel.passwordChecker)
        .textContentType(.password)
        .focused($focusedField, equals: .password)
        .onTapGesture { focusedField = .password }
    }
    
    private var confirmPassword: some View {
        CustomSecureField(placeholder: RegistrationStrings.confirmPassword.localized,
                          value: $viewModel.confirmPassword,
                          checker: $viewModel.confirmPasswordChecker)
        .textContentType(.password)
        .focused($focusedField, equals: .confirmPassword)
        .onTapGesture { focusedField = .confirmPassword }
    }
    
    private var submit: some View {
        PrimaryButton(title: RegistrationStrings.submit.localized, action: viewModel.onSubmitClick)
            .disabled(viewModel.isContinueDisabled)
            .simultaneousGesture(tapGesture)
    }
}

#Preview {
    ResetPasswordView(mobile: "", mobileCode: "", OTP: "", coordinator: ResetPasswordCoordinator(navigationController: UINavigationController()))
}
