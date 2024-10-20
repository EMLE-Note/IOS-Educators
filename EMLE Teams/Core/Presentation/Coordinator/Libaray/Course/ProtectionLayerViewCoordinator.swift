//
//  ProtectionLayerViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 15/08/2024.
//

import Foundation
import EMLECore
import UIKit

protocol ProtectionLayerViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func popView()
}

class ProtectionLayerViewCoordinator: MainCoordinator, ProtectionLayerViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() { }
    
    func start(courseId: Int? = nil, securityType: SecurityType, security: Security? = nil) {
        let view = ProtectionLayerView(courseId: courseId, securityType: securityType, security: security, coordinator: self)
        coordinateToView(view)
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
