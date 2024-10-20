//
//  LessonFolderDetailsCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 04/10/2024.
//

import Foundation
import EMLECore
import UIKit

protocol LessonFolderDetailsCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
        
    func goToUploadVideoView(folderId: Int)
    func goToEditParentFolder(folderId: Int)
    
    func popView()
}

class LessonFolderDetailsCoordinator: MainCoordinator, LessonFolderDetailsCoordinating {
    
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
        let view = LessonFolderDetailsView(folderId: folerId, coordinator: self)
        coordinateToView(view)
    }
    
    func goToUploadVideoView(folderId: Int) {
        let coordinator = UploadMaterialCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(folderId: folderId)
    }
    
    func goToEditParentFolder(folderId: Int) {
        let coordinator = EditParentFolderCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(folerId: folderId)
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
