//
//  CongratsCreateTeamCoordinating.swift
//  EMLE Teams
//
//  Created by iOSAYed on 04/09/2024.
//

import UIKit
import EMLECore

protocol CongratsCreateTeamCoordinating: AnyObject {
    func coordinateToHome()
}

class CongratsCreateTeamCoordinator: MainCoordinator, CongratsCreateTeamCoordinating {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let view = CongratsCreateTeamView(coordinator: self)
        coordinateToView(view)
    }
    
    func coordinateToHome() {
        let coordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
