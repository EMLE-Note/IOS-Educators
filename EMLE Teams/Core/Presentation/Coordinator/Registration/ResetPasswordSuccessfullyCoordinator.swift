//
//  ResetPasswordSuccessfullyCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 29/04/2024.
//

import UIKit
import EMLECore

protocol ResetPasswordSuccessfullyCoordinating: AnyObject { }

class ResetPasswordSuccessfullyCoordinator: MainCoordinator, ResetPasswordSuccessfullyCoordinating {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = ResetPasswordSuccessfullyView(coordinator: self)
        coordinateToView(view)
    }
}
