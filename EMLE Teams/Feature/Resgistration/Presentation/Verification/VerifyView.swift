//
//  VerifyView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 15/04/2024.
//

import SwiftUI
import EMLECore

struct VerifyView: View {
    
    @StateObject var viewModel: VerifyViewModel
    
    @FocusState var focusedField: Verification.FocusField?
    
    init(fromSignup: Bool, mobileCode: String, mobile: String, method: RegistrationMethod, telegramUrl: String?, coordinator: VerificationViewCoordinating) {
        _viewModel = StateObject(wrappedValue: VerifyViewModel(fromSignup: fromSignup, mobileCode: mobileCode, mobile: mobile, method: method, telegramUrl: telegramUrl, coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                
                navigationBar
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 24) {
                        HStack {
                            verifyYourAccount
                            
                            shield
                        }
                        weHaveSentVerificationCodeToTelegram
                        
                        verificationCode
                        
                        if viewModel.isTelegramMethod {
                            openTelegramAgain
                        } else {
                            HStack(spacing: 8) {
                                didNotGetTheCode
                                
                                resend
                            }
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 8) {
                            doNotHaveTelegram
                            
                            sendViaSMS
                        }
                        
                        Spacer()
                        
                        continueButton
                        
                        HStack(spacing: 8) {
                            haveAnAccount
                            
                            login
                        }
                    }
                    .padding(16)
                }
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
    
    private var verifyYourAccount: some View {
        Text(RegistrationStrings.verifyYourAccount.localized)
            .lineLimit(3)
            .customFont(size: 36, weight: ._500, lineHeight: 41)
            .customForeground(.onSurface)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var shield: some View {
        Image.shield
            .resizable()
            .frame(width: 100, height: 120)
    }
    
    private var verificationCode: some View {
        Verification(code: $viewModel.verificationCode.limit(viewModel.verificationCodeLimit),
                     focusedField: _focusedField)
    }
    
    private var weHaveSentVerificationCodeToTelegram: some View {
        Text(RegistrationStrings.weHaveSentVerificationCodeToTelegramS.localizedFormat(arguments: viewModel.fullMobile))
            .customFont(size: 14, weight: ._400, lineHeight: 21)
            .customForeground(.onSurface)
    }
    
    private var weHaveSentSmsWithVerificationCode: some View {
        Text(RegistrationStrings.weHaveSentSmsWithVerificationCodeS.localizedFormat(arguments: viewModel.mobile))
            .customFont(size: 14, weight: ._400, lineHeight: 21)
            .customForeground(.onSurface)
    }
    
    private var didNotGetTheCode: some View {
        Text(RegistrationStrings.didNotGetTheCode.localized)
            .customFont(size: 14, weight: ._400, lineHeight: 20)
            .customForeground(.onSurface)
    }
    
    private var resend: some View {
        Button {
            viewModel.onResendButtonClick()
        } label: {
            Text(BasicStrings.resendInDD.localizedFormat(arguments: viewModel.minuit, viewModel.second))
                .customFont(size: 14, weight: ._400, lineHeight: 20)
                .customForeground(.primary)
        }
        .simultaneousGesture(tapGesture)
    }
    
    private var doNotHaveTelegram: some View {
        Text(RegistrationStrings.doNotHaveTelegram.localized)
            .customFont(size: 14, weight: ._400, lineHeight: 20)
            .customForeground(.onSurface)
    }
    
    private var sendViaSMS: some View {
        Button {
            viewModel.onSendViaSMSClick()
        } label: {
            Text(RegistrationStrings.sendViaSMS.localized)
                .customFont(size: 14, weight: ._400, lineHeight: 20)
                .customForeground(.primary)
        }
        .simultaneousGesture(tapGesture)
    }
    
    private var openTelegramAgain: some View {
        Button {
            viewModel.onOpenTelegramAgainClick()
        } label: {
            Text(RegistrationStrings.openTelegramAgain.localized)
                .customStyle(.subheadline, .primary)
        }
        .simultaneousGesture(tapGesture)
    }
    
    private var sendViaTelegram: some View {
        Button {
            viewModel.onSendViaTelegramClick()
        } label: {
            Text(RegistrationStrings.sendViaTelegram.localized)
                .customFont(size: 14, weight: ._400, lineHeight: 20)
                .customForeground(.primary)
        }
        .simultaneousGesture(tapGesture)
    }
    
    private var continueButton: some View {
        PrimaryButton(title: RegistrationStrings.continueCase.localized, action:  viewModel.onContinueClick)
            .disabled(viewModel.isContinueDisable)
            .simultaneousGesture(tapGesture)
    }
    
    private var haveAnAccount: some View {
        Text(RegistrationStrings.haveAnAccount.localized)
            .customFont(size: 14, weight: ._400, lineHeight: 20)
            .customForeground(.onSurface)
    }
    
    private var login: some View {
        Button {
            viewModel.onLoginClick()
        } label: {
            Text(RegistrationStrings.login.localized)
                .customFont(size: 14, weight: ._400, lineHeight: 20)
                .customForeground(.primary)
        }
        .simultaneousGesture(tapGesture)
    }
}

#Preview {
    VerifyView(fromSignup: false, mobileCode: "", mobile: "", method: .telegram, telegramUrl: nil, coordinator: VerificationViewCoordinator(navigationController: UINavigationController()))
}
