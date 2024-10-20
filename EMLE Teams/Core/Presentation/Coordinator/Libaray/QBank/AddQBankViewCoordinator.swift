//
//  AddQBankViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/09/2024.
//

import Foundation
import EMLECore
import UIKit

protocol AddQBankViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func popView()
}

class AddQBankViewCoordinator: MainCoordinator, AddQBankViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() {
        let view = AddQBankView(coordinator: self)
        coordinateToView(view)
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
