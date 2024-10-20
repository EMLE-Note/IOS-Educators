//
//  SearchViewCoordinating.swift
//  EMLE Teams
//
//  Created by iOSAYed on 15/08/2024.
//

import EMLECore
import UIKit

protocol SearchViewCoordinating {
    func goToEnrollmentDetails(enrollment: Enrollment)
    func goToTransactionDetails(transaction: ExternalWallet)
//    func coordinateToEBook(eBook: EBook)
//    func coordinateToQuiz(quiz: Quiz)
}

class SearchViewCoordinator: MainCoordinator, SearchViewCoordinating {
  
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController,
         tabBarController: MainTabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() { }
    
    func goToEnrollmentDetails(enrollment: Enrollment) {
        let coordinator = EnrollmentDetailsCoordintor(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(enrollmentDetails: enrollment)
    }
    
    func goToTransactionDetails(transaction: ExternalWallet) {
        let coordinator = TransactionDetailsCoordinator(navigationController: navigationController, tabBarController: tabBarController)
        coordinator.start(transactionDetails: transaction)
    }
    
    
    
    
}
