//
//  ResetPasswordSuccessfullyViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 29/04/2024.
//

import Foundation
import EMLECore

final class ResetPasswordSuccessfullyViewModel: MainViewModel {
    
    var coordinator: ResetPasswordSuccessfullyCoordinating
    
    @Inject var resetAppUseCase: ResetAppUseCase
    
    init(coordinator: ResetPasswordSuccessfullyCoordinating) {
        self.coordinator = coordinator
    }
}

extension ResetPasswordSuccessfullyViewModel {
    
    func onAppear() {
        resetApp()
    }
    
    func onDisappear() { }
}

extension ResetPasswordSuccessfullyViewModel {
    
    private func resetApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.resetAppUseCase.execute()
        }
    }
}
