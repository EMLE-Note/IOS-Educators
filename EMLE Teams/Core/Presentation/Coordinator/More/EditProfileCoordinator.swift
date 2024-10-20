//
//  EditProfileCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 10/05/2024.
//

import UIKit
import EMLECore

protocol EditProfileCoordinating: AnyObject {
    func coordinateToBack()
}

class EditProfileCoordinator: MainCoordinator, EditProfileCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = EditProfileView(coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToBack() {
        navigationController.popViewController(animated: true)
    }
}
