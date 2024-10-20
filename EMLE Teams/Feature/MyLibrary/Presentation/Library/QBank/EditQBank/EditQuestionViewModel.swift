//
//  EditQuestionViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/09/2024.
//

import Foundation
import EMLECore
import SwiftUI
import Combine

class EditQuestionViewModel: MainViewModel {
    let coordinator: QBankViewCoordinating
    let qbankId: Int
    
    init(coordinator: QBankViewCoordinating, queationId: Int) {
        self.coordinator = coordinator
        self.qbankId = queationId
    }
    
    var isTabBarVisible: Bool { false }
    
}

extension EditQuestionViewModel {
    func onAppear() {
        
    }
    
    func qbankSettingTapped() {
        coordinator.goToQBankSettingView(qbankId: qbankId)
    }
    
    func queationTapped() {
        
    }
}
