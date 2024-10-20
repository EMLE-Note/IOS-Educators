//
//  EditCourseViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 10/08/2024.
//

import Foundation
import EMLECore
import UIKit

protocol EditCourseViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func goToCustomDialog(dialogType: CustomDialogType)
    func goToCourseSetting(courseId: Int)
    func goToVisiableView(courseId: Int)
    func goToTargetedView(courseId: Int)
    func goToProtectionLayerView(courseId: Int?, security: Security?, securityType: SecurityType)
    func popView()
}

extension EditCourseViewCoordinating {
    func goToProtectionLayerView(courseId: Int? = nil, security: Security? = nil, securityType: SecurityType) { }
}

class EditCourseViewCoordinator: MainCoordinator, EditCourseViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {}

    func start(courseId: Int) {
        let view = EditCourseView(courseId: courseId, coordinator: self)
        coordinateToView(view)
    }
    
    func goToCustomDialog(dialogType: CustomDialogType) {
        let coordinator = CustomDialogViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(dialogType: dialogType)
    }
    
    func goToCourseSetting(courseId: Int) {
        let coordinator = CourseSettingViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(courseId: courseId)
    }
    
    func goToTargetedView(courseId: Int) {
        let coordinator = TargetedLearnersViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(courseId: courseId)
    }
    
    func goToVisiableView(courseId: Int) {
        let coordinator = VisibilityViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(courseId: courseId)
    }
    
    func goToProtectionLayerView(courseId: Int? = nil, security: Security? = nil, securityType: SecurityType) {
        let coordinator = ProtectionLayerViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(courseId: courseId, securityType: securityType, security: security)
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
