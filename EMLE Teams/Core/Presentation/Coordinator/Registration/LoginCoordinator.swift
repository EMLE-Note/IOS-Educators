//
//  LoginCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 03/04/2024.
//

import UIKit
import EMLECore

protocol LoginCoordinating: AnyObject {
    func coordinateToHome()
    func coordinateToSignup()
    func coordinateToForgetPassword()
    func coordinateToCompleteDate()
}

class LoginCoordinator: MainCoordinator, LoginCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = LoginView(coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToHome() {
        let coordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
    
    func coordinateToSignup() {
        let coordinator = SignupCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
    
    func coordinateToForgetPassword() {
        let coordinator = ForgetPasswordCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
    
    func coordinateToCompleteDate() {
        let coordinator = CompleteYourProfileCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
