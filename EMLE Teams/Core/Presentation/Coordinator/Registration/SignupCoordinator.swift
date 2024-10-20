//
//  SignupCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 14/04/2024.
//

import UIKit
import EMLECore

protocol SignupCoordinating: AnyObject {
    func coordinateToVerification(mobile: String, mobileCode: String, method: RegistrationMethod, telegramUrl: String?)
    func coordinateToLogin()
}

class SignupCoordinator: MainCoordinator, SignupCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = SignupView(coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToVerification(mobile: String, mobileCode: String, method: RegistrationMethod, telegramUrl: String?) {
        let coordinator = VerificationViewCoordinator(navigationController: navigationController)
        coordinator.start(fromSignup: true, mobile: mobile, mobileCode: mobileCode, telegramUrl: telegramUrl)
    }
    
    func coordinateToLogin() {
        navigationController.popViewController(animated: true)
    }
}
