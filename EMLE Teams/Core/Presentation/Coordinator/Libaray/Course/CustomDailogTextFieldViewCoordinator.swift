//
//  CustomDailogTextFieldViewCoordinator.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/08/2024.
//

import Foundation
import EMLECore
import UIKit
import SwiftUI

protocol CustomDailogTextFieldViewCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
    
    func dismiss()
}

class CustomDailogTextFieldViewCoordinator: MainCoordinator, CustomDailogTextFieldViewCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    private var hostingController: UIHostingController<CustomDailogTextFieldView>?

    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController)
    {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }

    func start() {}
    
    func start(model: CustomDialogTextFieldModel) {
        let view = CustomDailogTextFieldView(coordinator: self, model: model)
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        self.hostingController = hostingController
        navigationController.present(hostingController, animated: true, completion: nil)
    }
    
    func dismiss() {
        hostingController?.dismiss(animated: true, completion: nil)
        hostingController = nil
    }
}
