//
//  EnrollmentDetailsViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 12/08/2024.
//

import Foundation
import EMLECore

final class EnrollmentDetailsViewModel:MainViewModel {
   
    let coordinator:EnrollmentDetailsCoordinting
    let transactionDetails:Enrollment
    init(transactionDetails:Enrollment,coordinator: EnrollmentDetailsCoordinting) {
        self.transactionDetails = transactionDetails
        self.coordinator = coordinator
    }
    
    var isTabBarVisible: Bool { false }

    var progress: String {
        let paidAmount = transactionDetails.price - transactionDetails.remained
        let totalPrice = transactionDetails.price
        let progress = (paidAmount / totalPrice) * 100
        return "\(progress.stringTwoDecimalDigit) %"
    }
    
    func onAppear() {
        
    }
}
