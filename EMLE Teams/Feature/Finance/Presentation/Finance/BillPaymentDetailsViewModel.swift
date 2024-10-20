//
//  BillPaymentDetailsViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import Foundation
import EMLECore

final class BillPaymentDetailsViewModel: MainViewModel {
    
    @Published var currentBills: Bills
    let coordinator:BillPaymentDetailsCoordinating
    
    init(currentBill:Bills,coordinator: BillPaymentDetailsCoordinating) {
        self.currentBills = currentBill
        self.coordinator = coordinator
    }
    
    var isTabBarVisible: Bool {
        false
    }
   
    
}

//MARK: Functions
extension BillPaymentDetailsViewModel {
    func onAppear() {
        
    }
    
    func onDisappear() {
        
    }
    
    func payBillClicked() {
        print("Pay")
    }
}
