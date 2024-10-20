//
//  QBankViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/09/2024.
//

import Foundation
import EMLECore
import UIKit

protocol QBankViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func goToQBankSettingView(qbankId: Int)
}

class QBankViewCoordinator: MainCoordinator, QBankViewCoordinating {
    
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
        let view = EditQuestionView(queationId: qbankId, coordinator: self)
        coordinateToView(view)
    }
    
    func goToQBankSettingView(qbankId: Int) {
        let coordinator = QBankSettingCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(qbankId: qbankId)
    }

}
