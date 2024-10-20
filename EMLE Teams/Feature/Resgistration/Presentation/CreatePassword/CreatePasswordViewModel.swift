//
//  CreatePasswordViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 16/04/2024.
//

import Foundation
import EMLECore
import Combine

final class CreatePasswordViewModel: MainViewModel {
    
    @Published var password = "" {
        didSet {
            validatePassword()
        }
    }
    
    @Published var confirmPassword = "" {
        didSet {
            validateConfirmPassword()
        }
    }
    
    @Published var passwordChecker: ViewChecker = ViewChecker(state: .empty, messages: [.wrong : RegistrationStrings.incorrectPassword.localized])
    
    @Published var confirmPasswordChecker: ViewChecker = ViewChecker(state: .empty, messages: [.wrong : RegistrationStrings.passwordsAreNotIdentical.localized])
    
    @Published var loadingState: LoadingState = .loaded
    
    var isContinueDisabled: Bool { !(passwordChecker.isCorrect && confirmPasswordChecker.isCorrect) }
    
    var mobileCode: String
    var mobile: String
    var OTP: String
    var coordinator: CreatePasswordCoordinating
    
    private var cancellables = Set<AnyCancellable>()
    
    @Inject var register3UseCase: Register3UseCase
    
    init(mobileCode: String, mobile: String, OTP: String, coordinator: CreatePasswordCoordinating) {
        self.mobileCode = mobileCode
        self.mobile = mobile
        self.OTP = OTP
        self.coordinator = coordinator
    }
}

extension CreatePasswordViewModel {
    
    func onAppear() {
        loadingState = .loaded
    }
    
    func onDisappear() { }
    
    func onPrivacyPolicyClick() {
        print("onPrivacyPolicyClick")
    }
    
    func onTermsAndCondition() {
        print("onTermsAndCondition")
    }
    
    func onContinueClick() {
        let register3 = Register3(mobile: mobile,
                                  mobileCode: mobileCode,
                                  OTP: OTP,
                                  password: password,
                                  confirmPassword: confirmPassword)
        
        createPassword(register3: register3)
    }
}

extension CreatePasswordViewModel {
    
    private func validatePassword() {
        if password.isEmpty {
            passwordChecker.state = .empty
        } else {
            passwordChecker.state = password.canBeUsedAsPassword() ? .correct : .wrong
        }
    }
    
    private func validateConfirmPassword() {
        if confirmPassword.isEmpty {
            confirmPasswordChecker.state = .empty
        } else {
            confirmPasswordChecker.state = password == confirmPassword ? .correct : .wrong
        }
    }
}

extension CreatePasswordViewModel: UseCaseViewModel {
    
    private func createPassword(register3: Register3) {
        do {
            loadingState = .loading
            try register3UseCase.execute(with: register3)
                .sink(receiveCompletion: handleUseCaseCompletion, receiveValue: handleResult)
                .store(in: &cancellables)
        } catch {
            loadingState = .failed
            showErrorToast(message: error.localizedDescription)
        }
    }
    
    private func handleResult(result: DomainWrapper<User>) {
        loadingState = .loaded
        if result.isSuccess {
            coordinator.coordinateToCompleteDate()
        } else{
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        loadingState = .failed
    }
}
