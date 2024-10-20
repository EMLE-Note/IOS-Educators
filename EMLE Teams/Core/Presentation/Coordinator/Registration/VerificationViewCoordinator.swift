//
//  VerificationViewCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 15/04/2024.
//

import UIKit
import EMLECore

protocol VerificationViewCoordinating: AnyObject {
    func coordinateBack()
    func coordinateToLogin()
    func coordinateToCreatePassword(mobile: String, mobileCode: String, OTP: String)
    func coordinateToResetPassword(mobile: String, mobileCode: String, OTP: String)
}

class VerificationViewCoordinator: MainCoordinator, VerificationViewCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func start(fromSignup: Bool, mobile: String, mobileCode: String, method: RegistrationMethod = .telegram, telegramUrl: String? = nil) {
        
        let view = VerifyView(fromSignup: fromSignup,
                              mobileCode: mobileCode,
                              mobile: mobile,
                              method: method,
                              telegramUrl: telegramUrl,
                              coordinator: self)
        
        coordinateToView(view)
    }
    
    func coordinateBack() {
        navigationController.popViewController(animated: true)
    }
    
    func coordinateToLogin() {
        navigationController.popViewController(animated: false)
        navigationController.popViewController(animated: true)
    }
    
    func coordinateToCreatePassword(mobile: String, mobileCode: String, OTP: String) {
        let coordinator = CreatePasswordCoordinator(navigationController: navigationController)
        coordinator.start(mobile: mobile, mobileCode: mobileCode, OTP: OTP)
    }
    
    func coordinateToResetPassword(mobile: String, mobileCode: String, OTP: String) {
        let coordinator = ResetPasswordCoordinator(navigationController: navigationController)
        coordinator.start(mobile: mobile, mobileCode: mobileCode, OTP: OTP)
    }
}
