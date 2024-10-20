//
//  LoginView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import SwiftUI
import EMLECore

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    enum FocusField: Hashable {
        case phoneNumber, password
    }
    
    @FocusState var focusedField: FocusField?
    
    @StateObject var viewModel: LoginViewModel
    
    init(coordinator: LoginCoordinating) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        
        MainView(viewModel: viewModel) {
            VStack(spacing: 24) {
                
                loginToYourAccount
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 16) {
                        
                        phoneNumber
                        
                        password
                        
                        forgetPassword
                    }
                    
                    login
                    
                    
                    //                VStack(spacing: 16) {
                    //
                    //                    google
                    //
                    //                    facebook
                    //
                    //                    apple
                    //                }
                    
                    doNotHaveAccountView
                        .padding(.top, 8)
                }
            }
            .padding(16)
            .onTapGesture { focusedField = nil }
            .withLoadingState(loadingState: viewModel.loadingState,
                              failureViewClickAction: viewModel.onAppear)
            .customSheet(isPresented: $viewModel.isPresentingCountryCodePicker, fraction: 0.9,detents: [.large]) {
                AllCountriesView(selectedCountryIso:  viewModel.country.isoCode,
                                 selectCountryAction: viewModel.setCountryCode)
            }
        }
    }
    
    private var tapGesture: some Gesture {
        TapGesture().onEnded {
            focusedField = nil
        }
    }
    
    private var loginToYourAccount: some View {
        HStack {
            Text(RegistrationStrings.loginToYourAccount.localized)
                .customFont(size: 36, weight: ._500, lineHeight: 41)
                .customForeground(.onSurface)
            Spacer()
        }
    }
    
    private var phoneNumber: some View {
        PhoneNumberTextField(placeholder: RegistrationStrings.phoneNumber.localized,
                             value: $viewModel.phoneNumber,
                             selectedCountry: $viewModel.selectedCountry,
                             selectedAction: viewModel.countryCodeClick)
        .keyboardType(.phonePad)
        .textContentType(.telephoneNumber)
        .focused($focusedField, equals: .phoneNumber)
        .onTapGesture {
            focusedField = .phoneNumber
        }
    }
    
    private var password: some View {
        CustomSecureField(placeholder: RegistrationStrings.password.localized,
                          value: $viewModel.password)
        .textContentType(.password)
        .focused($focusedField, equals: .password)
        .onTapGesture {
            focusedField = .password
        }
    }
    
    private var forgetPassword: some View {
        Button {
            viewModel.onForgetPasswordClick()
        } label: {
            Text(RegistrationStrings.forgetPassword.localized)
            .customFont(size: 14, weight: ._600, lineHeight: 20)
            .customForeground(.primary)
        }
    }
    
    private var login: some View {
        PrimaryButton(title: RegistrationStrings.login.localized, action:  viewModel.loginClick)
            .disabled(viewModel.isSignInDisable)
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
    
    private var doNotHaveAccountView: some View {
        HStack {
            Text(RegistrationStrings.doNotHaveAnAccount.localized)
                .customFont(size: 12, weight: ._500, lineHeight: 18)
                .customForeground(.onSurface)
            Button(action: {
                viewModel.signupClick()
            }, label: {
                Text(RegistrationStrings.signup.localized)
                    .customForeground(.primary)
                    .customFont(size: 12, weight: ._700, lineHeight: 18)
            })
        }
    }
}

#Preview {
    LoginView(coordinator: LoginCoordinator(navigationController: UINavigationController()))
}
