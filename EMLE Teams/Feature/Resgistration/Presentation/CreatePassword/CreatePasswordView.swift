//
//  CreatePasswordView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 16/04/2024.
//

import SwiftUI
import EMLECore

struct CreatePasswordView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    enum FocusField: Hashable {
        case password, confirmPassword
    }
    
    @FocusState var focusedField: FocusField?
    
    @StateObject var viewModel: CreatePasswordViewModel
    
    init(mobile: String, mobileCode: String, OTP: String, coordinator: CreatePasswordCoordinating) {
        _viewModel = StateObject(wrappedValue: CreatePasswordViewModel(mobileCode: mobileCode, mobile: mobile, OTP: OTP, coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 32) {
                        
                        createPassword
                        
                        VStack(spacing: 16) {
                            password
                            
                            confirmPassword
                        }
                        
                        Spacer()
                        
                        Spacer()
                        
                        VStack(spacing: 5) {
                            byClickingContinue
                            
                            HStack(spacing: 4) {
                                the
                                
                                privacyPolicy
                                
                                and
                                
                                termsConditions
                            }
                        }
                        
                        Spacer()
                        
                        continueButton
                        
                    }
                }
                .padding(16)
            }
            .onTapGesture { focusedField = nil }
            .navigationBarBackButtonHidden(true)
            .withLoadingState(loadingState: viewModel.loadingState, failureViewClickAction: viewModel.onAppear)
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
        HStack {
            Text(RegistrationStrings.createPassword.localized)
                .customFont(size: 36, weight: ._500, lineHeight: 41)
                .customForeground(.onSurface)
            
            Spacer()
        }
    }
    
    private var password: some View {
        CustomSecureField(placeholder: RegistrationStrings.password.localized,
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
    
    private var byClickingContinue: some View {
        Text(RegistrationStrings.byClickingContinueYouAgreeAndAcknowledge.localized)
            .customFont(size: 12, weight: ._500, lineHeight: 16)
            .customForeground(.onSurface)
    }
    
    private var the: some View {
        Text(RegistrationStrings.the.localized)
            .customFont(size: 12, weight: ._500, lineHeight: 16)
            .customForeground(.onSurface)
    }
    
    private var privacyPolicy: some View {
        Button {
            viewModel.onPrivacyPolicyClick()
        } label: {
            Text(RegistrationStrings.privacyPolicy.localized)
                .customFont(size: 12, weight: ._500, lineHeight: 16)
                .customForeground(.primary)
        }
    }
    
    private var and: some View {
        Text(RegistrationStrings.and.localized)
            .customFont(size: 12, weight: ._500, lineHeight: 16)
            .customForeground(.onSurface)
    }
    
    private var termsConditions: some View {
        Button {
            viewModel.onTermsAndCondition()
        } label: {
            Text(RegistrationStrings.termsConditions.localized)
                .customFont(size: 12, weight: ._500, lineHeight: 16)
                .customForeground(.primary)
        }
    }
    
    private var continueButton: some View {
        PrimaryButton(title: RegistrationStrings.continueCase.localized, action: viewModel.onContinueClick)
            .disabled(viewModel.isContinueDisabled)
            .simultaneousGesture(tapGesture)
    }
}

#Preview {
    CreatePasswordView(mobile: "", mobileCode: "", OTP: "", coordinator: CreatePasswordCoordinator(navigationController: UINavigationController()))
}
