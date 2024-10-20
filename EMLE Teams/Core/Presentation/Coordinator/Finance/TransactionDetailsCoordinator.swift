//
//  TransactionDetailsCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 21/07/2024.
//

import UIKit
import EMLECore


protocol TransactionDetailsCoordinting {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
}

class TransactionDetailsCoordinator: MainCoordinator,TransactionDetailsCoordinting  {
    
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {}
    
    func start(transactionDetails: ExternalWallet) {
        let view = TransactionDetailsView(transactionDetails: transactionDetails, coordinator: self)
        coordinateToView(view)
    }
    
}
