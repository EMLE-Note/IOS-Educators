//
//  ConfirmTransactionCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 26/07/2024.
//

import Foundation
import EMLECore
import UIKit

protocol ConfirmTransactionCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
}

class ConfirmTransactionCoordinator: ConfirmTransactionCoordinating, MainCoordinator {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let view = ConfirmTransactionView(coordinator: self)
        coordinateToView(view)
    }
    
    
}
