//
//  ResetPasswordViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 29/04/2024.
//

import Foundation
import EMLECore
import Combine

final class ResetPasswordViewModel: MainViewModel {
    
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
    
    private var cancellables = Set<AnyCancellable>()
    
    var mobileCode: String
    var mobile: String
    var OTP: String
    var coordinator: ResetPasswordCoordinating
    
    @Inject var forgetPassword3UseCase: ForgetPassword3UseCase
    
    init(mobileCode: String, mobile: String, OTP: String, coordinator: ResetPasswordCoordinating) {
        self.mobileCode = mobileCode
        self.mobile = mobile
        self.OTP = OTP
        self.coordinator = coordinator
    }
}

extension ResetPasswordViewModel {
    
    func onAppear() {
        loadingState = .loaded
    }
    
    func onDisappear() { }
    
    func onSubmitClick() {
        resetPassword(forgetPassword3:
                        ForgetPassword3(mobile: mobile,
                                        mobileCode: mobileCode,
                                        OTP: OTP,
                                        password: password,
                                        confirmPassword: confirmPassword)
        )
    }
}

extension ResetPasswordViewModel {
    
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

extension ResetPasswordViewModel: UseCaseViewModel {
    
    private func resetPassword(forgetPassword3: ForgetPassword3) {
        do {
            loadingState = .loading
            try forgetPassword3UseCase.execute(with: forgetPassword3)
                .sink(receiveCompletion: handleUseCaseCompletion,
                      receiveValue: handleResult)
                .store(in: &cancellables)
        } catch {
            loadingState = .failed
            showErrorToast(message: error.localizedDescription)
        }
    }
    
    private func handleResult(result: DomainWrapper<Bool>) {
        
        loadingState = .loaded
        if result.isSuccess {
            coordinator.coordinateToResetPasswordSuccessfully()
        } else{
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        loadingState = .failed
    }
}
