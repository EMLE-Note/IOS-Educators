//
//  SignupView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 14/04/2024.
//

import SwiftUI
import EMLECore

struct SignupView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    enum FocusField: Hashable {
        case phoneNumber
    }
    
    @FocusState var focusedField: FocusField?
    
    @StateObject var viewModel: SignupViewModel
    
    init(coordinator: SignupCoordinating) {
        _viewModel = StateObject(wrappedValue: SignupViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        
        MainView(viewModel: viewModel) {
            
            VStack(spacing: 0) {
                
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 24) {
                        
                        createNewAccount
                        
                        VStack(spacing: 16) {
                            
                            phoneNumber
                            
                            continueWithTelegram
                            
                            continueWithSMS
                        }
                        
                        //                    VStack(spacing: 16) {
                        //
                        //                        google
                        //
                        //                        facebook
                        //
                        //                        apple
                        //                    }
                        
                        Spacer()
                        
                        haveAccount
                    }
                }
                .padding(16)
            }
            .onTapGesture { focusedField = nil }
            .navigationBarBackButtonHidden(true)
            .withLoadingState(loadingState: viewModel.loadingState, failureViewClickAction: viewModel.reloadLoadingState)
            .customSheet(isPresented: $viewModel.isPresentingCountryCodePicker, fraction: 0.9,detents:[.large]) {
                AllCountriesView(selectedCountryIso: viewModel.country.isoCode,
                                 selectCountryAction: viewModel.setCountryCode)
            }
            .withCustomOverlayContent(isPresented: $viewModel.isPresentingTelegramDialog) {
                TelegramView(action: viewModel.onOpenTelegramClick)
            }
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
    
    private var createNewAccount: some View {
        HStack {
            Text(RegistrationStrings.createNewAccount.localized)
                .customFont(size: 36, weight: ._500, lineHeight: 41)
                .customForeground(.onSurface)
            Spacer()
        }
    }
    
    private var phoneNumber: some View {
        PhoneNumberTextField(placeholder: RegistrationStrings.phoneNumber.localized,
                             value: $viewModel.phoneNumber,
                             checker: $viewModel.phoneNumberChecker,
                             selectedCountry: $viewModel.selectedCountry,
                             selectedAction: viewModel.countryCodeClick)
        .keyboardType(.phonePad)
        .textContentType(.telephoneNumber)
        .focused($focusedField, equals: .phoneNumber)
        .onTapGesture {
            focusedField = .phoneNumber
        }
    }
    
    private var continueWithTelegram: some View {
        PrimaryButton(title: RegistrationStrings.continueWithTelegram.localized,
                      action:  viewModel.onContinueWithTelegramClick,
                      leadingIcon: .send)
        .disabled(viewModel.isContinueDisable)
        .simultaneousGesture(tapGesture)
    }
    
    private var continueWithSMS: some View {
        PrimaryButton(title: RegistrationStrings.continueWithSMS.localized,
                      action: viewModel.onContinueWithSMSClick,
                      leadingIcon: .message)
        .disabled(viewModel.isContinueDisable)
        .simultaneousGesture(tapGesture)
    }
    
    private var google: some View {
        
        PrimaryButton(title: RegistrationStrings.google.localized,
                      action: viewModel.onGoogleButtonClick,
                      leadingIcon: .google,
                      textColor: .onSurface,
                      backgroundColor: .error)
        .simultaneousGesture(tapGesture)
    }
    
    private var facebook: some View {
        PrimaryButton(title: RegistrationStrings.facebook.localized,
                      action: viewModel.onFacebookButtonClick,
                      leadingIcon: .facebook,
                      textColor: .onSurface,
                      backgroundColor: .facebook)
        .simultaneousGesture(tapGesture)
    }
    
    private var apple: some View {
        PrimaryButton(title: RegistrationStrings.apple.localized,
                      action: viewModel.onAppleButtonClick,
                      leadingIcon: .apple,
                      textColor: .onSurface,
                      backgroundColor: .onSecondary)
        .simultaneousGesture(tapGesture)
    }
    
    private var haveAccount: some View {
        HStack {
            Text(RegistrationStrings.haveAnAccount.localized)
                .customFont(size: 12, weight: ._500, lineHeight: 18)
                .customForeground(.onSurface)
            
            Button {
                viewModel.onLoginClick()
            } label: {
                Text(RegistrationStrings.login.localized)
                    .customForeground(.primary)
                    .customFont(size: 12, weight: ._700, lineHeight: 18)
            }
        }
    }
}

#Preview {
    SignupView(coordinator: SignupCoordinator(navigationController: UINavigationController()))
}
