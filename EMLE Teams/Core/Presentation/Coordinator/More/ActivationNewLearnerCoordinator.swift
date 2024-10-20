//
//  ActivationNewLearnerCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/10/2024.
//

import Foundation
import EMLECore
import UIKit
import SwiftUI

protocol ActivationNewLearnerCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func dismiss()
}

class ActivationNewLearnerCoordinator: MainCoordinator, ActivationNewLearnerCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController, tabBarController: MainTabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let view = ActivationNewLearnerView(coordinator: self)
        let hostingController = UIHostingController(rootView: view)
        
        hostingController.modalPresentationStyle = .pageSheet
        
        if #available(iOS 15.0, *) {
            hostingController.sheetPresentationController?.detents = [.large()]
        }
        
        navigationController.present(hostingController, animated: true, completion: nil)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
