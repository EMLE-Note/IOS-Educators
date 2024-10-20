//
//  LoginViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import Foundation
import EMLECore
import CountryPicker
import Combine

final class LoginViewModel: MainViewModel {
    
    @Published var phoneNumber: String = "" {
        didSet {
            validatePhone()
        }
    }
    
    @Published var password: String = ""
    
    @Published var checkRememberMe = true
    
    @Published var loadingState: LoadingState = .loaded
    
    @Published var isPresentingCountryCodePicker: Bool = false
    
    @Published var country = Country(isoCode: "EG")
    
    @Published var selectedCountry: String = ""
    
    @Published var phoneNumberChecker: ViewChecker = ViewChecker(state: .empty, messages: [.wrong : RegistrationStrings.incorrectPhoneText.localized])
    
    var fullPhoneNumber: String {
        if !phoneNumber.isEmpty, phoneNumber.first == "0" {
            
            var phone = phoneNumber
            phone.removeFirst()
            
            return "+" + country.phoneCode + phone
        } else {
            
            return "+" + country.phoneCode + phoneNumber
        }
    }
    
    var isSignInDisable: Bool { phoneNumber.isEmpty || password.isEmpty }
    
    var coordinator: LoginCoordinating
    
    var cancellables = Set<AnyCancellable>()
    
    @Inject var loginUseCase: LoginUseCase
    
    init(coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
}

extension LoginViewModel {
    
    func onAppear() {
        configureCountryCode()
        
        loadingState = .loaded
    }
    
    func onDisappear() { }
    
    func onForgetPasswordClick() {
        coordinator.coordinateToForgetPassword()
    }
    
    func loginClick() {
        
        var mobile = phoneNumber
        
        if !phoneNumber.isEmpty, phoneNumber.first == "0" {
            
            mobile.removeFirst()
        }
        
        login(login: Login(mobileCode: "+\(country.phoneCode)",
                           mobile: mobile,
                           password: password,
                           FCMToken: "")
        )
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
    
    func signupClick() {
        coordinator.coordinateToSignup()
    }
    
    func countryCodeClick() {
        isPresentingCountryCodePicker = true
    }
    
    func setCountryCode(country: Country) {
        
        self.country = country
        
        isPresentingCountryCodePicker = false
        
        validatePhone()
        
        setCountryPhoneCode()
        
    }
}

extension LoginViewModel {
    
    private func configureCountryCode() {
        
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            
            country = Country(isoCode: countryCode)
            setCountryPhoneCode()
        }
        
    }
    
    private func setCountryPhoneCode() {
        
        selectedCountry = RegistrationStrings.phoneCodeSS.localizedFormat(arguments: country.isoCode.getFlag(), "+\(country.phoneCode)")
    }
    
    private func validatePhone() {
        if fullPhoneNumber.isEmpty {
            phoneNumberChecker.state = .empty
        }
        else {
            phoneNumberChecker.state = fullPhoneNumber.isValidPhone() ? .correct : .wrong
        }
    }
}

extension LoginViewModel: UseCaseViewModel {
    
    private func login(login: Login) {
        do {
            loadingState = .loading
            try loginUseCase.execute(with: login)
                .sink(receiveCompletion: handleUseCaseCompletion,
                      receiveValue: handleResult)
                .store(in: &cancellables)
        }
        catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func handleResult(result: DomainWrapper<User>) {
        
        loadingState = .loaded
        if result.isSuccess, let user = result.data {
            if user.status == .notCompleted {
                coordinator.coordinateToCompleteDate()
            } else if user.status == .finished {
                coordinator.coordinateToHome()
            } else {
                
            }
        }
        else {
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        loadingState = .failed
    }
}
