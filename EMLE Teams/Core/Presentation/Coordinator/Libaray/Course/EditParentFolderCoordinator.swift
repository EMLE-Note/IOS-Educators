//
//  EditParentFolderCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation
import EMLECore
import UIKit

protocol EditParentFolderCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    func popView()
}

class EditParentFolderCoordinator: MainCoordinator, EditParentFolderCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() { }
    
    func start(folerId: Int) {
        let view = EditParentFolderView(folderId: folerId, coordinator: self)
        coordinateToView(view)
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
