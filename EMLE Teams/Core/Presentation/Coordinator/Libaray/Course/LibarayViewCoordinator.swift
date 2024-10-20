//
//  LibarayViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/08/2024.
//

import Foundation
import EMLECore
import UIKit

protocol LibraryViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func goToCreateNewCourse()
    func goToCourseDetails(courseId: Int)
    func goToEditQBank(qbankId: Int)
    func goToAddNewQBank()
}

class LibarayViewCoordinator: MainCoordinator, LibraryViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() { }
    
    func goToCreateNewCourse() {
        let coordinator = AddNewCourseViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start()
    }
    
    func goToCourseDetails(courseId: Int) {
        let coordinator = CourseDetailsViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(courseId: courseId)
    }
    
    func goToEditQBank(qbankId: Int) {
        let coordinator = QBankViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(qbankId: qbankId)
    }
    
    func goToAddNewQBank() {
        let coordinator = AddQBankViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start()
    }
}
