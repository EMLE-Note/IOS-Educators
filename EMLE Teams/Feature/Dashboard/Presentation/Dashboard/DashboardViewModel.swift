//
//  DashboardViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 14/06/2024.
//

import Combine
import EMLECore
import Foundation

class DashboardViewModel: MainViewModel {
    private var coordinator: DashboardViewCoordinating
    
    init(coordinator: DashboardViewCoordinating) {
        self.coordinator = coordinator
    }
    
    @Inject var getMyTeamsUseCase: GetMyTeamsUseCase
    @Inject var changeTeamIdUseCase: ChangeTeamIdUseCase
    @Inject var getCurrentTeamIdUseCase: GetTeamIdUseCase
    @Inject var getUserUseCase: GetUserUseCase<User>
    var cancellables = Set<AnyCancellable>()

    
    @Published var currentUser: User? = nil
    @Published var myTeams: [Team]? = nil
    @Published var selectedTeam: Team? = nil
    @Published var selectedTeamId: TeamId? = nil
    @Published var isPresentingMyTeamsList: Bool = false
    @Published var isPresentingLoadingInitializing: Bool = false
    @Published var getMyTeamsLoadingState: LoadingState = .loaded
}

extension DashboardViewModel {
    func onAppear() {
        loadData()
    }
    
    func notificationAction() {
        print("Notification Action")
    }
    
    func teamListAction() {
        isPresentingMyTeamsList = true
    }
    
    func settingAction() {
        print("Setting Action")
    }
    
    func createTeamAction() {
        isPresentingMyTeamsList = false
        coordinator.goToCreateTeamCoordinator()
    }
    
    func countinueAsIndividualAction() {
        print("countinue As Individual Action")
    }
    
    func changeTeamId(to id: Int) {
        let teamId = TeamId(id: id)
        changeTeamIdUseCase.execute(with: teamId)
        getCurrentTeamId()
        if let selectedTeam = myTeams?.first(where: { $0.teamId == teamId.id }) {
            self.selectedTeam = selectedTeam
        }
    }
    
    func getCurrentTeamId() {
        if let teamId = getCurrentTeamIdUseCase.execute() {
            selectedTeamId = teamId
            print(teamId)
            changeTeamIdUseCase.execute(with: teamId)
        }else {
            guard let teamId = myTeams?.first?.teamId else {return}
            selectedTeamId = TeamId(id: teamId)
            changeTeamIdUseCase.execute(with: TeamId(id: teamId))
        }
    }
    
    func setupInitializingTeamDashboardLoading() {
        isPresentingMyTeamsList = false
        isPresentingLoadingInitializing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.isPresentingLoadingInitializing = false
        }
    }
}

extension DashboardViewModel {
    private func loadData() {
        getCurrentUser()
        getMyTeams{
            self.getCurrentTeamId()
            self.getCurrentTeam()
        }
       
    }
    
    private func getCurrentTeam() {
        if let teamId = selectedTeamId?.id {
            selectedTeam = myTeams?.first(where: { $0.teamId == teamId })
        }
    }
    
    private func getCurrentUser() {
        currentUser = getUserUseCase.execute()
    }
}

// MARK: Get My Teams API Call

extension DashboardViewModel {
    private func getMyTeams(completion: @escaping () -> Void) {
        getMyTeamsLoadingState = .loading
        
        do {
            try getMyTeamsUseCase.execute()
                .sink(receiveCompletion: handleGetMyTeamsCompletion, receiveValue: { result in
                    self.handleGetMyTeamsDataResult(result: result)
                    completion()
                })
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func handleGetMyTeamsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            getMyTeamsLoadingState = .failed
        }
    }
    
    private func handleGetMyTeamsDataResult(result: DomainWrapper<[Team]>) {
        getMyTeamsLoadingState = .loaded
        
        if result.isSuccess, let myTeams = result.data {
            self.myTeams = myTeams
            if selectedTeam == nil {
                selectedTeam = myTeams.first
                selectedTeamId = TeamId(id: myTeams.first?.teamId ?? 0)
            }
        } else {
            print(result.message)
            showErrorToast(message: result.message)
        }
    }
}
