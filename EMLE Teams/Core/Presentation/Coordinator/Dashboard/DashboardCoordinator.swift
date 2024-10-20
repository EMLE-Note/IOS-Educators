//
//  DashboardCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 14/06/2024.
//

import UIKit
import EMLECore

protocol DashboardViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    func goToCreateTeamCoordinator()
}


class DashboardViewCoordinator: MainCoordinator, DashboardViewCoordinating {
   
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() { }
    
    func coordinateToFilters() {
        coordinateToUnderConstructionView()
    }
    
    func goToCreateTeamCoordinator() {
        let coordinator = CreateTeamCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinate(to: coordinator)
    }
    
    
}

