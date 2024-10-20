//
//  CongratsCreateTeamViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 04/09/2024.
//

import Foundation
import EMLECore

final class CongratsCreateTeamViewModel: MainViewModel {
    
    var coordinator: CongratsCreateTeamCoordinating
    
    init(coordinator: CongratsCreateTeamCoordinating) {
        self.coordinator = coordinator
    }
    var isTabBarVisible: Bool {false}
}

extension CongratsCreateTeamViewModel {
    
    func onAppear() { }
    
    func onDisappear() { }
    
    func onGoToHomeClicked() {
        coordinator.coordinateToHome()
    }
}
