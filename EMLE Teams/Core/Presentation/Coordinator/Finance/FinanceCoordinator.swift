//
//  FinanceCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 28/06/2024.
//

import UIKit
import EMLECore

protocol FinanceViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    func goToBillPaymentDetails(currentBills:Bills)
    func goToCheckout(dataFromFinance:DataPassedToCheckout)
    func goToExternalWallet()
    func goToEnrollment()
}

class FinanceViewCoordinator: MainCoordinator, FinanceViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() {}
    
    func goToBillPaymentDetails(currentBills: Bills) {
        let coordinator = BillPaymentDetailsCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(currentBills: currentBills)
    }
    
    func goToCheckout(dataFromFinance:DataPassedToCheckout) {
        let coordinator = CheckoutViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(dataFromFinance: dataFromFinance)
    }
    
    func goToExternalWallet() {
        let coordinator = ExternalWalletCoordinator(navigationController: navigationController, tabBarController: tabBarController)
           coordinator.start()
    }
   
    func goToEnrollment() {
        let coordinator = EnrollmentViewCoordinator(navigationController: navigationController, tabBarController: tabBarController)
           coordinator.start()
    }
}
