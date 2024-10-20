//
//  SignupViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 14/04/2024.
//

import Foundation
import EMLECore
import Combine
import CountryPicker
import UIKit

final class SignupViewModel: MainViewModel {
    
    @Published var phoneNumber = "" {
        didSet {
            validatePhoneNumber()
        }
    }
    
    @Published var selectedCountry = ""
    
    @Published var country = Country(isoCode: "EG")
    
    @Published var isPresentingCountryCodePicker: Bool = false
    
    @Published var isPresentingTelegramDialog: Bool = false
    
    @Published var phoneNumberChecker: ViewChecker = ViewChecker(state: .empty, messages: [.wrong : RegistrationStrings.incorrectPhoneText.localized])
    
    @Published var loadingState: LoadingState = .loaded
    
    var fullPhoneNumber: String {
        if !phoneNumber.isEmpty, phoneNumber.first == "0" {
            
            var phone = phoneNumber
            phone.removeFirst()
            
            return "+" + country.phoneCode + phone
        } else {
            
            return "+" + country.phoneCode + phoneNumber
        }
    }
    
    var mobile: String {
        var mobile = phoneNumber
        
        if !phoneNumber.isEmpty, phoneNumber.first == "0" {
            
            mobile.removeFirst()
        }
        
        return mobile
    }
    
    var isContinueDisable: Bool { !phoneNumberChecker.isCorrect }
    
    private let coordinator: SignupCoordinating
    
    var cancellables = Set<AnyCancellable>()
    
    var telegramURL: String?
    
    @Inject var register1UseCase: Register1UseCase
    
    init(coordinator: SignupCoordinating) {
        self.coordinator = coordinator
    }
}

extension SignupViewModel {
    
    func onAppear() {
        configureCountryCode()
    }
    
    func onDisappear() { }
    
    func reloadLoadingState() {
        loadingState = .loaded
    }
    
    func setCountryCode(country: Country) {
        self.country = country
        
        isPresentingCountryCodePicker = false
        
        validatePhoneNumber()
        
        setCountryPhoneCode()
    }
    
    func countryCodeClick() {
        isPresentingCountryCodePicker = true
    }
    
    func onContinueWithTelegramClick() {
        signup(register1: Register1(mobileCode: "+\(country.phoneCode)", mobile: mobile, method: .telegram))
    }
    
    func onContinueWithSMSClick() {
        signup(register1: Register1(mobileCode: "+\(country.phoneCode)", mobile: mobile, method: .sms))
    }
    
    func onGoogleButtonClick() {
        print("Google Button Click.")
    }
    
    func onFacebookButtonClick() {
        print("Facebook Button Click.")
    }
    
    func onAppleButtonClick() {
        print("Apple Button Click.")
    }
    
    func onLoginClick() {
        coordinator.coordinateToLogin()
    }
    
    func onOpenTelegramClick() {
        if let telegramURL {
            openTelegram(url: telegramURL)
        } else {
            coordinator.coordinateToVerification(mobile: mobile, mobileCode: "+\(country.phoneCode)", method: .sms, telegramUrl: nil)
        }
        
        isPresentingTelegramDialog = false
    }
}

extension SignupViewModel {
    
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
            
            coordinator.coordinateToVerification(mobile: mobile, mobileCode: "+\(country.phoneCode)", method: .telegram, telegramUrl: url)
        } else {
            print("You don't have telegram.")
          }
    }
}

extension SignupViewModel: UseCaseViewModel {
    
    private func signup(register1: Register1) {
        do {
            loadingState = .loading
            try register1UseCase.execute(with: register1)
                .sink(receiveCompletion: handleUseCaseCompletion, receiveValue: handleSignupResult)
                .store(in: &cancellables)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func handleSignupResult(result: DomainWrapper<VerificationURL>) {
        
        loadingState = .loaded
        if result.isSuccess {
            self.telegramURL = result.data?.url
            self.isPresentingTelegramDialog = true
        } else {
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        showErrorToast(message: error.localizedDescription)
        loadingState = .failed
    }
}
