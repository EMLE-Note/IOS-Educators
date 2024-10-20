//
//  ForgetPasswordView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import SwiftUI
import EMLECore

struct ForgetPasswordView: View {
    
    enum FocusField: Hashable {
        case phoneNumber
    }
    
    @FocusState var focusedField: FocusField?
    
    @StateObject var viewModel: ForgetPasswordViewModel
    
    init(coordinator: ForgetPasswordCoordinating) {
        _viewModel = StateObject(wrappedValue: ForgetPasswordViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        forgetYourPassword
                            .padding(.top, 32)
                        
                        enterYourPassword
                            .padding(.top, 8)
                        
                        phoneNumber
                            .padding(.top, 36)
                        
                        sendViaTelegram
                            .padding(.top, 32)
                        
                        sendViaSMS
                            .padding(.top, 16)
                        
                        Spacer()
                    }
                }
                .padding(16)
            }
            .onTapGesture { focusedField = nil }
            .navigationBarHidden(true)
            
            .customSheet(isPresented: $viewModel.isPresentingCountryCodePicker,fraction: 0.9, detents: [.large], content: {
                AllCountriesView(selectedCountryIso: viewModel.country.isoCode,
                                 selectCountryAction: viewModel.setCountryCode)
            })
            
            .withLoadingState(loadingState: viewModel.loadingState,
                              failureViewClickAction: viewModel.resetLoadingState)
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
    
    private var forgetYourPassword: some View {
        Text(RegistrationStrings.forgetYourPassword.localized)
            .customFont(size: 36, weight: ._500, lineHeight: 41)
            .customForeground(.onSurface)
    }
    
    private var enterYourPassword: some View {
        Text(RegistrationStrings.enterYourPhoneNumberToGetOTP.localized)
            .customFont(size: 14, weight: ._400, lineHeight: 21)
            .customForeground(.onSurface)
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
    
    private var sendViaTelegram: some View {
        PrimaryButton(title: RegistrationStrings.sendViaTelegram.localized,
                      action: viewModel.onSendCodeViewTelegram,
                      leadingIcon: .send)
        .disabled(viewModel.isSendCodeDisable)
        .simultaneousGesture(tapGesture)
    }
    
    private var sendViaSMS: some View {
        PrimaryButton(title: RegistrationStrings.sendViaSMS.localized,
                      action: viewModel.onSendCodeViewSMS,
                      leadingIcon: .message)
        .disabled(viewModel.isSendCodeDisable)
        .simultaneousGesture(tapGesture)
    }
    
}

#Preview {
    ForgetPasswordView(coordinator: ForgetPasswordCoordinator(navigationController: UINavigationController()))
}
