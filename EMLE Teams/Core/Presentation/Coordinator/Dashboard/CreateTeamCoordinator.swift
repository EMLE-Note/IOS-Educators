//
//  CreateTeamCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 24/06/2024.
//

import UIKit
import EMLECore

protocol CreateTeamCoordinating: AnyObject {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func coordinateToCongratsCreateTeam()
}


class CreateTeamCoordinator: MainCoordinator, CreateTeamCoordinating {
   
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() { 
        let view = CreateTeamView(coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToCongratsCreateTeam() {
        let coordinator = CongratsCreateTeamCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
    
}

