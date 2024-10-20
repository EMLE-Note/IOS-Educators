//
//  ManageTeamViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 15/09/2024.
//

import EMLECore
import Combine

class ManageTeamViewModel: MainViewModel {
    
    var coordinator: ManageTeamCoordinating
    var cancellables = Set<AnyCancellable>()

    @Inject var memberListUseCase: MemberListUseCase
    
    init(coordinator: ManageTeamCoordinating) {
        self.coordinator = coordinator
    }
    var isTabBarVisible: Bool { false }
    
    @Published var options: [String] = ["Current Members","Activity Log"]
    @Published var selectedTab: Int = 0
    @Published var memberList: [Member] = .placeholder
    
    @Published var isMemberOptionsViewPresented: Bool = false
    @Published var getMemberListLoadingState: LoadingState = .loaded

 
}

extension ManageTeamViewModel {
    func onAppear() {
        getMemberList()
    }
    
    func onAddMemberClick() {
        coordinator.coordinateAddMember()
    } 
    
    func optionAction() {
        print("optionAction")
        isMemberOptionsViewPresented = true
    }
    
    func handleOptionClicked(option: MemberOptions) {
        switch option {
        case .viewLogs:
            print("goToEnrollmentDetails()")
        case .editMember:
            print("onDeclineOptionClicked()")
        case .deactivate:
            "showDialog(option: .deactivate)" 
        case .removeMember:
            "showDialog(option: .removeMember)"
        }
    }
}

// MARK: Get Member List

extension ManageTeamViewModel {
    
    func getMemberList() {
        getMemberListLoadingState = .loading
        
        do {
            try memberListUseCase.execute()
                .sink(receiveCompletion: handleGetMemberListCompletion, receiveValue: handleGetMemberListResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleGetMemberListCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            getMemberListLoadingState = .failed
        }
    }
    
    func handleGetMemberListResult(result: DomainWrapper<[Member]>) {
        getMemberListLoadingState = .loaded
        
        if result.isSuccess, let MemberList = result.data {
            print(MemberList)
            memberList = MemberList
        } else {
            print(result.message)
            showToast(message: result.message)
        }
    }
}
