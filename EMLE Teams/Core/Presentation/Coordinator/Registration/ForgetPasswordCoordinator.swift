//
//  ForgetPasswordCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import UIKit
import EMLECore

protocol ForgetPasswordCoordinating: AnyObject {
    func coordinateToVerifyAccount(mobile: String, mobileCode: String, telegramUrl: String?)
}

class ForgetPasswordCoordinator: MainCoordinator, ForgetPasswordCoordinating {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = ForgetPasswordView(coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToVerifyAccount(mobile: String, mobileCode: String, telegramUrl: String?) {
        let coordinator = VerificationViewCoordinator(navigationController: navigationController)
        coordinator.start(fromSignup: false, mobile: mobile, mobileCode: mobileCode, telegramUrl: telegramUrl)
    }
}
