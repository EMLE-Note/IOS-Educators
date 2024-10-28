//
//  EditProfileCoordinator.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 10/05/2024.
//

import UIKit
import EMLECore

protocol TeamInvitationsCoordinating: AnyObject {
    func coordinateToBack()
}

class TeamInvitationsCoordinator: MainCoordinator, TeamInvitationsCoordinating {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = TeamInvitationsView(coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToBack() {
        navigationController.popViewController(animated: true)
    }
}
