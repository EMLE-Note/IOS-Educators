//
//  BillPaymentDetailsCoordinating.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import UIKit
import EMLECore

protocol BillPaymentDetailsCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
}

class BillPaymentDetailsCoordinator: MainCoordinator, BillPaymentDetailsCoordinating {
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() {}
    
    func start(currentBills:Bills) {
        let view = BillPaymentDetailsView(currentBills: currentBills, coordinator: self)
        coordinateToView(view)
    }
}
