//
//  ChildernFolderViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 20/08/2024.
//

import Foundation
import EMLECore
import UIKit

protocol ChildernFolderViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func goToEditParentFolder(folderId: Int)
    func goToSubChildernFolder(folderId: Int)
    func goToLessonFolderDetails(folderId: Int)
    
    func popView()
}

class ChildernFolderViewCoordinator: MainCoordinator, ChildernFolderViewCoordinating {
    
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
        let view = ChildernFolderView(folderId: folerId, coordinator: self)
        coordinateToView(view)
    }
    
    func goToEditParentFolder(folderId: Int) {
        let coordinator = EditParentFolderCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(folerId: folderId)
    }
    
    func goToSubChildernFolder(folderId: Int) {
        let view = ChildernFolderView(folderId: folderId, coordinator: self)
        coordinateToView(view)
    }
    
    func goToLessonFolderDetails(folderId: Int) {
        let coordinator = LessonFolderDetailsCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(folerId: folderId)
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
