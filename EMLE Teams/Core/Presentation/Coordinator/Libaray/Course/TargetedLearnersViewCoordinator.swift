//
//  TargetedLearnersViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import Foundation
import EMLECore
import UIKit

protocol TargetedLearnersViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func popView()
}

class TargetedLearnersViewCoordinator: MainCoordinator, TargetedLearnersViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() { }
    
    func start(courseId: Int) {
        let view = TargetedLearnersView(courseId: courseId, coordinator: self)
        coordinateToView(view)
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
