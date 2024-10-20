//
//  CompleteYourProfileCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 20/04/2024.
//

import UIKit
import EMLECore

protocol CompleteYourProfileCoordinating: AnyObject {
    func coordinateToCongrats()
}

class CompleteYourProfileCoordinator: MainCoordinator, CompleteYourProfileCoordinating {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = CompleteYourProfileView(coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToCongrats() {
        let coordinator = CongratsCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
