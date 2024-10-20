//
//  ActivationCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 11/10/2024.
//

import Foundation
import EMLECore
import UIKit

protocol ActivationCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
        
    func goToActivationNewLearner()
}


class ActivationCoordinator: MainCoordinator, ActivationCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController, tabBarController: MainTabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let view = ActivationView(coordinator: self)
        coordinateToView(view)
    }
    
    func goToActivationNewLearner() {
        let coordinator = ActivationNewLearnerCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start()
    }
}
