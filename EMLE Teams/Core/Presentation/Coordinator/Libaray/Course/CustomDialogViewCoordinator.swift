//
//  CustomDialogViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 11/08/2024.
//

import Foundation
import EMLECore
import UIKit
import SwiftUI

protocol CustomDialogViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func dismiss()
}

class CustomDialogViewCoordinator: MainCoordinator, CustomDialogViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    private var hostingController: UIHostingController<CustomDialogView>?

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() {}
    
    func start(dialogType: CustomDialogType) {
//        let view = CustomDialogView(coordinator: self, dialogType: dialogType)
//        let hostingController = UIHostingController(rootView: view)
//        hostingController.modalPresentationStyle = .overCurrentContext
//        hostingController.view.backgroundColor = .clear 
//        self.hostingController = hostingController
//        navigationController.present(hostingController, animated: true, completion: nil)
    }
    
    func dismiss() {
        hostingController?.dismiss(animated: true, completion: nil)
        hostingController = nil
    }
}
