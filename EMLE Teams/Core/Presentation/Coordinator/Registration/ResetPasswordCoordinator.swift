//
//  ResetPasswordCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 29/04/2024.
//

import UIKit
import EMLECore

protocol ResetPasswordCoordinating: AnyObject {
    func coordinateToResetPasswordSuccessfully()
}

class ResetPasswordCoordinator: MainCoordinator, ResetPasswordCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func start(mobile: String, mobileCode: String, OTP: String) {
        let view = ResetPasswordView(mobile: mobile, mobileCode: mobileCode, OTP: OTP, coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToResetPasswordSuccessfully() {
        let coordinator = ResetPasswordSuccessfullyCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
