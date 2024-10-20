//
//  ManageTeamCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/09/2024.
//

import UIKit
import EMLECore

protocol AddNewMemberCoordinating {
    
}

class AddNewMemberCoordinator: MainCoordinator, AddNewMemberCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController, tabBarController: MainTabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let view = AddNewMemberView(coordinator: self)
        coordinateToView(view)
    }
   
}
