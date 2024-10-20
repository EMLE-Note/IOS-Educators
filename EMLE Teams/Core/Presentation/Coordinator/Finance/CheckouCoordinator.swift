//
//  CheckoutCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/07/2024.
//

import UIKit
import EMLECore

protocol CheckoutViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    func goToPaymentView(url:String)
}

class CheckoutViewCoordinator: MainCoordinator, CheckoutViewCoordinating {
   
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() {}
    
    func start(dataFromFinance:DataPassedToCheckout) {
        let view = CheckoutView(dataFromFinance:dataFromFinance, coordinator: self)
        coordinateToView(view)
    }
    func goToPaymentView(url:String) {
        let coordinator = PaymentCoordinator(navigationController: navigationController)
        coordinator.start(url: url)
    }
    
}
