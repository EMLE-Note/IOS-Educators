//
//  TabBarCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//

import UIKit
import EMLECore

class TabBarCoordinator: MainCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarViewController = MainTabBarController()
        if let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window {
            window.rootViewController = tabBarViewController
        }
    }
}
