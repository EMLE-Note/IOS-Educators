//
//  PaymentCoordinator.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/07/2024.
//

import UIKit
import EMLECore

protocol PaymentCoordinating: AnyObject {
    func popPaymentView()
}

class PaymentCoordinator: MainCoordinator, PaymentCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func start(url:String) {
        let view = PaymentView(url: url, coordinator: self)
        coordinateToView(view)
    }
   
    func popPaymentView() {
        navigationController.popViewController(animated: true)
    }
}
