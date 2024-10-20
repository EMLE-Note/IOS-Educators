//
//  SplashViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//

import Foundation
import EMLECore

final class SplashViewModel: MainViewModel {
    
    @Published var logoScale: CGFloat = 0
    
    @Published var logoOpacity: CGFloat = 0
    
    private var animationDurations: [CGFloat] = [0.0, 1.0, 1.75, 2.50]
    
    @Inject var getUserUseCase: GetUserUseCase<User>
    
    var coordinator: SplashCoordinating
    
    init(coordinator: SplashCoordinating) {
        self.coordinator = coordinator
    }
    
    func onAppear() {
        
        startAnimationSequence()
        
        startValidatingSession()
    }
    
    private func startValidatingSession() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let user = self.getUserUseCase.execute()
            
            if user != nil {
                self.coordinator.coordinateToMainScreen()
            }
            else  {
                self.coordinator.coordinateToSignIn()
            }
        }
    }
    
    private func startAnimationSequence() {
        
        logoScale = 0.0
        logoOpacity = 0.0
        
        withOptionalAnimation(.easeIn(duration: animationDurations[1] - animationDurations[0])
            .delay(animationDurations[0])) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
        
        withOptionalAnimation(.easeInOut(duration: animationDurations[2] - animationDurations[1])
            .delay(animationDurations[1])) {
                logoScale = 0.8
            }
        
        withOptionalAnimation(.easeOut(duration: animationDurations[3] - animationDurations[2])
            .delay(animationDurations[2])) {
                logoScale = 1.2
            }
    }
}
