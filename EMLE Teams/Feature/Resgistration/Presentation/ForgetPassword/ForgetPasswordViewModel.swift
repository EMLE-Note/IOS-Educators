//
//  ForgetPasswordViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import Foundation
import EMLECore
import CountryPicker
import Combine
import UIKit

final class ForgetPasswordViewModel: MainViewModel {
    
    @Published var phoneNumber: String = "" {
        didSet {
            validatePhoneNumber()
        }
    }
    
    @Published var isPresentingCountryCodePicker = false
    
    @Published var country = Country(isoCode: "EG")
    
    @Published var selectedCountry = ""
    
    @Published var loadingState: LoadingState = .loaded
    
    @Published var isPresentingTelegramDialog: Bool = false
    
    @Published var phoneNumberChecker: ViewChecker = ViewChecker(state: .empty, messages: [.wrong : RegistrationStrings.incorrectPhoneText.localized])
    
    var fullPhoneNumber: String {
        if !phoneNumber
            .isEmpty
            , phoneNumber.first == "0"{
            
            var phone = phoneNumber
            phone.removeFirst()
            return "+" + country.phoneCode + phone
        } else {
            return "+" + country.phoneCode + phoneNumber
        }
    }
    
    var isSendCodeDisable: Bool { !phoneNumberChecker.isCorrect }
    
    var mobile: String {
        var mobile = phoneNumber
        
        if !phoneNumber.isEmpty, phoneNumber.first == "0" {
            
            mobile.removeFirst()
        }
        
        return mobile
    }
    
    var cancellables = Set<AnyCancellable>()
    
    var coordinator: ForgetPasswordCoordinating
    
    var telegramURL: String?
    
    @Inject var forgetPassword1UseCase: ForgetPassword1UseCase
    
    init(coordinator: ForgetPasswordCoordinating) {
        self.coordinator = coordinator
    }
}

extension ForgetPasswordViewModel {
    
    func onAppear() { 
        configureCountryCode()
    }
    
    func onDisappear() { }
    
    func resetLoadingState() {
        loadingState = .loaded
    }
    
    func countryCodeClick() {
        isPresentingCountryCodePicker = true
    }
    
    func setCountryCode(country: Country) {
        self.country = country
        
        isPresentingCountryCodePicker = false
        
        validatePhoneNumber()
        
        setCountryPhoneCode()
    }
    
    func onSendCodeViewTelegram() {
        
        forgetPassword(forgetPassword1: ForgetPassword1(mobile: mobile,
                                                        mobileCode: "+\(country.phoneCode)",
                                                        method: .telegram))
    }
    
    func onSendCodeViewSMS() {
        
        forgetPassword(forgetPassword1: ForgetPassword1(mobile: mobile,
                                                        mobileCode: "+\(country.phoneCode)",
                                                        method: .sms))
    }
    
    func onOpenTelegramClick() {
        if let telegramURL {
            openTelegram(url: telegramURL)
        } else {
            coordinator.coordinateToVerifyAccount(mobile: mobile, mobileCode: "+\(country.phoneCode)", telegramUrl: nil)
        }
        isPresentingTelegramDialog = false
    }
}

extension ForgetPasswordViewModel {
    
    private func configureCountryCode() {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            
            country = Country(isoCode: countryCode)
            setCountryPhoneCode()
        }
    }
    
    private func setCountryPhoneCode() {
        selectedCountry = RegistrationStrings.phoneCodeSS.localizedFormat(arguments: country.isoCode.getFlag(), "+\(country.phoneCode)")
    }
    
    private func validatePhoneNumber() {
        if phoneNumber.isEmpty {
            phoneNumberChecker.state = .empty
        } else {
            phoneNumberChecker.state = fullPhoneNumber.isValidPhone() ? .correct : .wrong
        }
    }
    
    private func openTelegram(url: String) {
        let botURL = URL(string: url)
        
        if UIApplication.shared.canOpenURL(botURL! as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(botURL! as URL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(botURL! as URL)
            }
            
            coordinator.coordinateToVerifyAccount(mobile: mobile, mobileCode: "+\(country.phoneCode)", telegramUrl: url)
        } else {
            showToast(message: "You don't have telegram.")
          }
    }
}

extension ForgetPasswordViewModel: UseCaseViewModel {
    
    private func forgetPassword(forgetPassword1: ForgetPassword1) {
        
        do {
            
            loadingState = .loading
            
            try forgetPassword1UseCase.execute(with: forgetPassword1)
                .sink(receiveCompletion: handleUseCaseCompletion,
                      receiveValue: handleForgetPasswordResult)
                .store(in: &cancellables)
            
        } catch {
            showErrorToast(message: error.localizedDescription)
            loadingState = .failed
        }
    }
    
    private func handleForgetPasswordResult(result: DomainWrapper<VerificationURL>) {
        
        loadingState = .loaded
        if result.isSuccess {
            if let telegramURL = result.data?.url {
                self.telegramURL = telegramURL
                self.isPresentingTelegramDialog = true
            } else {
                coordinator.coordinateToVerifyAccount(mobile: mobile, mobileCode: "+\(country.phoneCode)", telegramUrl: nil)
            }
        } else {
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        loadingState = .failed
    }
}
