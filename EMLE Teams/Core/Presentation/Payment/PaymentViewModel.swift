//
//  PaymentViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/07/2024.
//

import Foundation
import Combine
import EMLECore

class PaymentViewModel: MainViewModel {
    
    let coordinator:PaymentCoordinating
    let url:String
    
    @Published var isLoading: LoadingState = .loaded
    
    init(url:String,coordinator: PaymentCoordinating) {
        self.url = url
        self.coordinator = coordinator
    }
    
    var paymentURL:URL? {
        if let url = URL(string: url) {
            return url
        }
        return nil
    }
    
    
    var isTabBarVisible: Bool {false}
    
    func onAppear() {}
    
    
}

extension PaymentViewModel {
    
    func paymentResult(result:PaymentCallBackType){
        
        switch result {
        case .success:
            popPaymentView()
        case .failure:
            print("failure")
            popPaymentView()
        case .unknown:
            print("unknown")
        }
    }
    
    private func popPaymentView() {
        coordinator.popPaymentView()
    }
    
}
