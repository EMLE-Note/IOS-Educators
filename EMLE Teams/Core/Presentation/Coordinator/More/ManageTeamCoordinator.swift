//
//  ManageTeamCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 15/09/2024.
//

import Foundation
import EMLECore
import UIKit

protocol ManageTeamCoordinating {
    func coordinateAddMember()
}

class ManageTeamCoordinator: MainCoordinator, ManageTeamCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController, tabBarController: MainTabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let view = ManageTeamView(coordinator: self)
        coordinateToView(view)
    }
   
    func coordinateAddMember(){
        let coordinator = AddNewMemberCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinate(to: coordinator)
    }
}
