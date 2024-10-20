//
//  CreateTeamViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 24/06/2024.
//

import UIKit
import EMLECore
import Combine

class CreateTeamViewModel: MainViewModel {
    private var coordinator: CreateTeamCoordinating
    var cancellables = Set<AnyCancellable>()

    init(coordinator: CreateTeamCoordinating) {
        self.coordinator = coordinator
    }
    @Inject var createTeamUseCase: CreateTeamUseCase

    var isTabBarVisible: Bool { false }
    var sourceType: ImagePickerSourceType = .photos
    var didSelectImage = false
    
    @Published var createTeamsSteps: CreateTeamSteps = .first
    @Published var imagePickerPresenting = false
    @Published var teamName = ""
    @Published var overView = ""
    @Published var createTeamLoadingState: LoadingState = .loaded
    @Published var teamImage: ImagePickerImage = .empty {
        didSet {
            didSelectImage = true
        }
    }
    

    
    
}

extension CreateTeamViewModel {
    func onAppear() {}
    
    var NextButtonTitle: String {
        createTeamsSteps == .first ? DashboardStrings.exit.localized : DashboardStrings.back.localized
    }
    
    func NextButtonAction() -> EmptyAction {
        createTeamsSteps == .first ? exitAction : backAction
    }
    
    func exitAction() {
        print("Exit Action")
    }
    
    func skipAction() {
        createTeam()
    }
    
    func onUploadPhotoClick() {
        sourceType = .photos
        imagePickerPresenting = true
    }
    
    func backAction() {
        switch createTeamsSteps {
        case .first:
            print("Exit")
        case .second:
            withOptionalAnimation {
                createTeamsSteps = .first
            }
        case .third:
            withOptionalAnimation {
                createTeamsSteps = .second
            }
        }
    }
    
    func nextAction() {
        switch createTeamsSteps {
        case .first:
            withOptionalAnimation {
                createTeamsSteps = .second
            }
        case .second:
            withOptionalAnimation {
                createTeamsSteps = .third
            }
        case .third:
            //Create Team
            createTeam()
        }
    }
}

extension CreateTeamViewModel {
   private func goToCongratsView(){
        coordinator.coordinateToCongratsCreateTeam()
    }
}

extension CreateTeamViewModel {
    private func createTeam(){
        let params = CreateTeamParameters(name: teamName, type: "team", about: overView, image:teamImage.imageData )
        creatTeam(createTeamParams: params)
    }
}

//MARK: Create team API Call
extension CreateTeamViewModel {
    func creatTeam(createTeamParams:CreateTeamParameters) {
        createTeamLoadingState = .loading
        
        do {
            try createTeamUseCase.execute(params: createTeamParams)
                .sink(receiveCompletion: handleCreateTeamCompletion, receiveValue: handleCreateTeamDataResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleCreateTeamCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            createTeamLoadingState = .failed
        }
    }
    
    func handleCreateTeamDataResult(result: DomainWrapper<CreateTeam>) {
        createTeamLoadingState = .loaded
        
        if result.isSuccess, let createTeamResult = result.data {
            print(createTeamResult)
            goToCongratsView()
        } else {
            print(result.message)
            showToast(message: result.message)
        }
    }
}
