//
//  ExternalWalletCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 18/07/2024.
//

import UIKit
import EMLECore


protocol ExternalWalletCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
   func  goToTransactionDetails(transactionDetails:ExternalWallet)
    func goToConfirmTransactionView()
}
class ExternalWalletCoordinator: MainCoordinator,ExternalWalletCoordinating  {
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let view = ExternalWalletView(coordinator: self)
        coordinateToView(view)
    }
    
    func goToTransactionDetails(transactionDetails:ExternalWallet) {
        let coordinator = TransactionDetailsCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(transactionDetails: transactionDetails)
    }
    
    func goToConfirmTransactionView() {
        let coordinator = ConfirmTransactionCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start()
    }
    
}

