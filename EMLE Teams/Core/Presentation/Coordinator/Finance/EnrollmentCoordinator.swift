//
//  EnrollmentCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/08/2024.
//

import EMLECore
import UIKit

protocol EnrollmentViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    func goToEnrollmentDetails(enrollmentDetails:Enrollment)
}

class EnrollmentViewCoordinator: MainCoordinator, EnrollmentViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() {
        let view = EnrollmentView(coordinator: self)
        coordinateToView(view)
    }
    
    func goToEnrollmentDetails(enrollmentDetails:Enrollment) {
        let coordinator = EnrollmentDetailsCoordintor(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(enrollmentDetails: enrollmentDetails)
    }
}
