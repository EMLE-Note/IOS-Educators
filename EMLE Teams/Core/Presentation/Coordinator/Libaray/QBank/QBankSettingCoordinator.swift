//
//  QBankSettingCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 25/09/2024.
//

import Foundation
import EMLECore
import UIKit

protocol QBankSettingCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func popView()
}

class QBankSettingCoordinator: MainCoordinator, QBankSettingCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() { }
    
    func start(qbankId: Int) {
        let view = QBankSettingView(qbankId: qbankId, coordinator: self)
        coordinateToView(view)
    }
    
    func popView() {
        navigationController.popViewController(animated: true)
    }

}
