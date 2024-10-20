//
//  EnrollmentDetailsCoordintor.swift
//  EMLE Teams
//
//  Created by iOSAYed on 12/08/2024.
//

import UIKit
import EMLECore


protocol EnrollmentDetailsCoordinting {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
}

class EnrollmentDetailsCoordintor: MainCoordinator,EnrollmentDetailsCoordinting  {
    
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {}
    
    func start(enrollmentDetails: Enrollment) {
        let view = EnrollmentDetailsView(transactionDetails: enrollmentDetails, coordinator: self)
        coordinateToView(view)
    }
    
}
