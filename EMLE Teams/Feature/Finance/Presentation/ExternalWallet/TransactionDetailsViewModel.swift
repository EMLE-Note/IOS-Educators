//
//  TransactionDetailsViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 21/07/2024.
//

import Foundation
import EMLECore

final class TransactionDetailsViewModel:MainViewModel {
   
    let coordinator:TransactionDetailsCoordinting
    let transactionDetails:ExternalWallet
    init(transactionDetails:ExternalWallet,coordinator: TransactionDetailsCoordinting) {
        self.transactionDetails = transactionDetails
        self.coordinator = coordinator
    }
    
    var isTabBarVisible: Bool { false }

    var progress: String {
        let paidAmount = transactionDetails.amount
        let totalPrice = transactionDetails.enrollment.price
        let progress = (paidAmount / totalPrice) * 100
        return "\(progress.stringTwoDecimalDigit) %"
    }
    
    func onAppear() {
        
    }
}
