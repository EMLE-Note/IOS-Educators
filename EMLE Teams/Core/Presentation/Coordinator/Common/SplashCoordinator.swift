//
//  SplashCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//

import UIKit
import EMLECore

protocol SplashCoordinating: AnyObject {
    func coordinateToSignIn()
    func coordinateToMainScreen()
}

class SplashCoordinator: MainCoordinator, SplashCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let splashView = SplashView(coordinator: self)
        coordinateToView(splashView)
    }
    
    func coordinateToMainScreen() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
    }
    
    func coordinateToSignIn() {
        let signInCoordinator = LoginCoordinator(navigationController: navigationController)
        coordinate(to: signInCoordinator)
    }
}
