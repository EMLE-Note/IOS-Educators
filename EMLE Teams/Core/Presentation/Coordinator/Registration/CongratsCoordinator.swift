//
//  CongratsCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import UIKit
import EMLECore

protocol CongratsCoordinating: AnyObject {
    func coordinateToHome()
}

class CongratsCoordinator: MainCoordinator, CongratsCoordinating {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let view = CongratsView(coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToHome() {
        let coordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
