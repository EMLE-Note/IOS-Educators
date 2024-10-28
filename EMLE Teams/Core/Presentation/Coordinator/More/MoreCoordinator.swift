//
//  MoreCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 08/05/2024.
//

import UIKit
import EMLECore

protocol MoreCoordinating { 
    func coordinateToEditProfile()
    func coordinateManageTeam()
    
    func goToEnrollment()
    func coordinateTeamInvitations()
}

class MoreCoordinator: MainCoordinator, MoreCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController, tabBarController: MainTabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() { }
    
    func coordinateToEditProfile() {
        let coordinator = EditProfileCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
    func coordinateManageTeam() {
        let coordinator = ManageTeamCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinate(to: coordinator)
    }
    
    func coordinateTeamInvitations() {
        let coordinator = TeamInvitationsCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
    
    func goToEnrollment() {
        let coordinator = ActivationCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start()
    }
}
