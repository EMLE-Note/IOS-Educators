//
//  TeamInvitationsViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/10/2024.
//

import EMLECore
import Combine

class TeamInvitationsViewModel: MainViewModel {
    
    var coordinator: TeamInvitationsCoordinating
    var cancellables = Set<AnyCancellable>()

    
    init(coordinator: TeamInvitationsCoordinating) {
        self.coordinator = coordinator
    }
    var isTabBarVisible: Bool { false }
    
    @Inject var getInvitationsList: GetInvitationsListUseCase
    @Inject var invitationsActionUseCase: InvitationsActionUseCase

    
    @Published var selectedTab: Int = 0
    @Published var invitationsList: [Invitation] = .placeholder
    @Published var getInvitationListLoadingState: LoadingState = .loaded
    @Published var inviatationActionLoadingState: LoadingState = .loaded

 
}

extension TeamInvitationsViewModel {
    func onAppear() {
        fetchInvitations()
    }
    
    func onDeclineClick(id: Int) {
        action(invitationID: id, action: .decline)
    }
    
    func onAcceptClick(id: Int) {
        action(invitationID: id, action: .accept)
    }
}

// MARK: - Get invitation List -

extension TeamInvitationsViewModel {
    func fetchInvitations() {
        getInvitationListLoadingState = .loading
        do {
            invitationsList = .placeholder
            
            try getInvitationsList.execute()
                .sink(receiveCompletion: handleCompletion,
                      receiveValue: handleContentRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            getInvitationListLoadingState = .failed
        }
    }
    
    func handleContentRequestsResult(invitation: DomainWrapper<[Invitation]>) {
        getInvitationListLoadingState = .loaded
        
        if invitation.isSuccess, let invitationData = invitation.data {
            self.invitationsList = invitationData
        } else {
            print(invitation.message)
            showErrorToast(message: invitation.message)
        }
    }
}

// MARK: - Actions request -

extension TeamInvitationsViewModel {
    func action(invitationID: Int,action:InvitationActionType) {
        let params = InvitationActionParameters(action: [action.rawValue])
        do {
            
            try invitationsActionUseCase.execute(invitationID: invitationID,params: params)
                .sink(receiveCompletion: handleCompletion,
                      receiveValue: handleContentRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleContentRequestsResult(activation: DomainWrapper<InvitationActionResponse>) {
        inviatationActionLoadingState = .loaded
        
        if activation.isSuccess {
            showSuccessToast(message: activation.message)
        } else {
            print(activation.message)
            inviatationActionLoadingState = .failed
            showErrorToast(message: activation.message)
        }
    }
}
