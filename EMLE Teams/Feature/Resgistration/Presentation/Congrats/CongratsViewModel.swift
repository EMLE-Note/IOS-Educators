//
//  CongratsViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 28/04/2024.
//

import Foundation
import EMLECore

final class CongratsViewModel: MainViewModel {
    
    var coordinator: CongratsCoordinating
    
    init(coordinator: CongratsCoordinating) {
        self.coordinator = coordinator
    }
}

extension CongratsViewModel {
    
    func onAppear() { }
    
    func onDisappear() { }
    
    func onStartLearningClick() {
        coordinator.coordinateToHome()
    }
}
