//
//  UploadMaterialCoordinating.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 05/10/2024.
//

import Foundation
import EMLECore
import UIKit
import SwiftUI

protocol UploadMaterialCoordinating {
    var navigationController: UINavigationController { get set }
    var tabBarController: MainTabBarController { get set }
        
    func dismiss()
}

class UploadMaterialCoordinator: MainCoordinator, UploadMaterialCoordinating {
    
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    private var hostingController: UIHostingController<UploadMaterialView>?
    
    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() { }
    
    func start(folderId: Int) {
        if hostingController != nil {
            print("An upload is already in progress.")
            return
        }
        
        let view = UploadMaterialView(folderId: folderId, coordinator: self)
        let hostingController = UIHostingController(rootView: view)
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        self.hostingController = hostingController
        navigationController.present(hostingController, animated: true, completion: nil)
    }
    
    func dismiss() {
        guard let hostingController = hostingController else {
            print("No view to dismiss")
            return
        }
        
        hostingController.dismiss(animated: true, completion: { [weak self] in
            self?.hostingController = nil
        })
    }
}
