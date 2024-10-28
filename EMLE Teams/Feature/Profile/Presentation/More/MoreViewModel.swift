//
//  MoreViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 08/05/2024.
//

import Foundation
import EMLECore

class MoreViewModel: MainViewModel {
    
    @Published var user: User = .dummy
    
    @Published var isPresentingConfirmationDialog = false
    
    var coordinator: MoreCoordinating
    
    @Inject var getUserUseCase: GetUserUseCase<User>
    @Inject var logoutUseCase: LogoutUserUseCase
    
    init(coordinator: MoreCoordinating) {
        self.coordinator = coordinator
    }
}

extension MoreViewModel {
    
    func onAppear() {
        user = getUserUseCase.execute()!
        print(user.token)
        print(user.image)
    }
    
    func onEditProfileClick() {
        coordinator.coordinateToEditProfile()
    }
    
    func onEnrollmentClick() {
        coordinator.goToEnrollment()
    }
    
    func onManageTeamClick() {
        coordinator.coordinateManageTeam()
    }
    
    func onTeamInvitationsClick() {
        coordinator.coordinateTeamInvitations()
    }
    
    func onHelpAndSupportClick() {
        print("onHelpAndSupportClick")
    }
    
    func onSendFeedbackClick() {
        print("onSendFeedbackClick")
    }
    
    func onAboutEMLEClick() {
        print("onAboutEMLEClick")
    }
    
    func onShareAppClick() {
        print("onShareAppClick")
    }
    
    func onLogoutClick() {
        isPresentingConfirmationDialog = true
    }
    
    func logout() {
        isPresentingConfirmationDialog = false
        logoutUseCase.execute()
    }
}
