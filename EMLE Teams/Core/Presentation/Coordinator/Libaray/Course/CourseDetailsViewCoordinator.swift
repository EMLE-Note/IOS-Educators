//
//  CourseDetailsViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 08/08/2024.
//

import Foundation
import EMLECore
import UIKit

protocol CourseDetailsViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func goToCustomDialog(dialogType: CustomDialogType)
    func goToCustomDialogTextField(model: CustomDialogTextFieldModel)
    func goToEditCourse(courseId: Int)
    func goToChildernFolder(folderId: Int)
    func goToProtectionLayerView(courseId: Int?, security: Security?, securityType: SecurityType)
    func popView()
}

extension CourseDetailsViewCoordinating {
    func goToProtectionLayerView(courseId: Int? = nil, security: Security? = nil, securityType: SecurityType) { }
}

class CourseDetailsViewCoordinator: MainCoordinator, CourseDetailsViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() { }

    func start(courseId: Int) {
        let view = CourseDetailsView(courseId: courseId, coordinator: self)
        coordinateToView(view)
    }
    
    func goToCustomDialog(dialogType: CustomDialogType) {
        let coordinator = CustomDialogViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(dialogType: dialogType)
    }
    
    func goToEditCourse(courseId: Int) {
        let coordinator = EditCourseViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(courseId: courseId)
    }
    
    func goToCustomDialogTextField(model: CustomDialogTextFieldModel) {
        let coordinator = CustomDailogTextFieldViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(model: model)
    }
    
    func goToChildernFolder(folderId: Int) {
        let coordinator = ChildernFolderViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(folerId: folderId)
    }
    
    func goToProtectionLayerView(courseId: Int? = nil, security: Security? = nil, securityType: SecurityType) {
        let coordinator = ProtectionLayerViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(courseId: courseId, securityType: securityType, security: security)
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }
}
