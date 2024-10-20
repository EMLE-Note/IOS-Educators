//
//  AppCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//


import UIKit
import EMLECore

class AppCoordinator: AppCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    let window: UIWindow
    
    required init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() { }
    
    func start(showSplash: Bool) {
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if showSplash {
            let splashCoordinator = SplashCoordinator(navigationController: navigationController)
            coordinate(to: splashCoordinator)
        }
        else {
            let signInCoordinator = LoginCoordinator(navigationController: navigationController)
            coordinate(to: signInCoordinator)
        }
    }
}
