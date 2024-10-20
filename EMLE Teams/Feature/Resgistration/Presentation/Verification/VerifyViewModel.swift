//
//  VerifyViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 15/04/2024.
//

import Foundation
import EMLECore
import Combine
import UIKit

final class VerifyViewModel: MainViewModel {
    
    @Published var verificationCode: String = ""
    
    @Published var loadingState: LoadingState = .loaded
    
    var verificationCodeLimit: Int = 6
    
    var minuit = 0
    var second = 10
    
    var isContinueDisable: Bool { !(verificationCode.count == 6) }
    
    var cancellable = Set<AnyCancellable>()
    
    let rangeToReplace = NSRange(location: 1, length: 9)
    
    var isTelegramMethod: Bool { method == .telegram }
    
    var fromSignup: Bool
    var mobileCode: String
    var mobile: String
    var coordinator: VerificationViewCoordinating
    var fullMobile: String
    var method: RegistrationMethod
    var telegramUrl: String?
    
    @Inject var register2UseCase: Register2UseCase
    
    @Inject var forgetPassword2UseCase: ForgetPassword2UseCase
    
    init(fromSignup: Bool, mobileCode: String, mobile: String, method: RegistrationMethod, telegramUrl: String?, coordinator: VerificationViewCoordinating) {
        self.fromSignup = fromSignup
        self.mobileCode = mobileCode
        self.mobile = mobile
        self.coordinator = coordinator
        self.fullMobile = mobileCode + mobile
        self.method = method
        self.telegramUrl = telegramUrl
        
        if let startIndex = fullMobile.index(fullMobile.startIndex, offsetBy: rangeToReplace.location, limitedBy: fullMobile.endIndex),
           let endIndex = fullMobile.index(startIndex, offsetBy: rangeToReplace.length, limitedBy: fullMobile.endIndex) {
            fullMobile.replaceSubrange(startIndex..<endIndex, with: String(repeating: "x", count: rangeToReplace.length))
        }
    }
}

extension VerifyViewModel {
    
    func onAppear() {
        loadingState = .loaded
    }
    
    func onDisappear() { }
    
    func onResendButtonClick() {
        print("onResendButtonClick")
    }
    
    func onSendViaSMSClick() {
        print("onSendViewSMSClick")
    }
    
    func onSendViaTelegramClick() {
        print("onSendViaTelegramClick")
    }
    
    func onContinueClick() {
        if fromSignup {
            register2(register2: Register2(mobile: mobile, mobileCode: mobileCode, OTP: verificationCode))
        } else {
            forgetPassword2(forgetPassword2: ForgetPassword2(mobile: mobile, mobileCode: mobileCode, OTP: verificationCode))
        }
    }
    
    func onLoginClick() {
        coordinator.coordinateToLogin()
    }
    
    func onOpenTelegramAgainClick() {
        if let telegramUrl {
            openTelegram(url: telegramUrl)
        }
    }
}

extension VerifyViewModel {
    
    private func openTelegram(url: String) {
        let botURL = URL(string: url)
        
        if UIApplication.shared.canOpenURL(botURL! as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(botURL! as URL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(botURL! as URL)
            }
        } else {
            print("You don't have telegram.")
          }
    }
}

extension VerifyViewModel: UseCaseViewModel {
    
    private func register2(register2: Register2) {
        do {
            loadingState = .loading
            try register2UseCase.execute(with: register2)
                .sink(receiveCompletion: handleUseCaseCompletion, receiveValue: handleResultOfVerification)
                .store(in: &cancellable)
        } catch {
            showErrorToast(message: error.localizedDescription)
        }
    }
    
    private func handleResultOfVerification(result: DomainWrapper<User>) {
        
        loadingState = .loaded
        if result.isSuccess {
            coordinator.coordinateToCreatePassword(mobile: mobile, mobileCode: mobileCode, OTP: verificationCode)
        } else {
            print(result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        showErrorToast(message: error.localizedDescription)
        loadingState = .failed
    }
}
extension VerifyViewModel {
    
    private func forgetPassword2(forgetPassword2: ForgetPassword2) {
        do {
            loadingState = .loading
            try forgetPassword2UseCase.execute(with: forgetPassword2)
                .sink(receiveCompletion: handleUseCaseCompletion,
                      receiveValue: handleForgetPassword2Result)
                .store(in: &cancellable)
        } catch {
            showErrorToast(message: error.localizedDescription)
        }
    }
    
    private func handleForgetPassword2Result(result: DomainWrapper<Bool>) {
        loadingState = .loaded
        if result.isSuccess {
            coordinator.coordinateToResetPassword(mobile: mobile, mobileCode: mobileCode, OTP: verificationCode)
        } else {
            print(result.message)
        }
    }
}
