//
//  CreatePasswordCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 16/04/2024.
//

import UIKit
import EMLECore

protocol CreatePasswordCoordinating: AnyObject {
    func coordinateToCompleteDate()
}

class CreatePasswordCoordinator: MainCoordinator, CreatePasswordCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func start(mobile: String, mobileCode: String, OTP: String) {
        
        let view = CreatePasswordView(mobile: mobile, mobileCode: mobileCode, OTP: OTP, coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToCompleteDate() {
        let coordinator = CompleteYourProfileCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
