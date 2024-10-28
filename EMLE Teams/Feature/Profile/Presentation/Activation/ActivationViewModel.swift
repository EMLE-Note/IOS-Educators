//
//  ActivationViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 11/10/2024.
//

import Foundation
import EMLECore
import CountryPicker
import Combine

class ActivationViewModel: MainViewModel {
    let coordinator: ActivationCoordinating
    init(coordinator: ActivationCoordinating) {
        self.coordinator = coordinator
    }
    
    var cancellables = Set<AnyCancellable>()
    var isTabBarVisible: Bool { false }
    
    @Published private var selectedIndices: Set<Int> = []
    @Published private(set) var selectedActivationIds: Set<Int> = []
    @Published var activationData: [Activations] = []
    @Published var activationLoadingState: LoadingState = .loaded
    
    @Inject var getActivationsUseCase: GetActivationsUseCase
    @Inject var acceptActivationUseCase: AcceptActivationUseCase
    @Inject var rejectActivationUseCase: RejectActivationUseCase
    @Inject var acceptAllActivationUseCase: AcceptAllActivationUseCase
    
}

extension ActivationViewModel {
    func onAppear() {
        fetchActivations() 
    }
    
    func isSelected(index: Int) -> Bool {
        selectedIndices.contains(index)
    }
    
    func setSelected(_ isSelected: Bool, index: Int) {
        if isSelected {
            selectedIndices.insert(index)
            selectedActivationIds.insert(activationData[index].activationID)
        } else {
            selectedIndices.remove(index)
            selectedActivationIds.remove(activationData[index].activationID)
        }
    }
}

extension ActivationViewModel {
    func approveAllTapped() {
        if selectedActivationIds.isEmpty {
            let allActivationIds = activationData.map { $0.activationID }
            acceptAllActivation(activationID: allActivationIds)
        } else {
            acceptAllActivation(activationID: Array(selectedActivationIds))
        }
    }
    
    func approveTapped(at index: Int) {
        guard index >= 0 && index < activationData.count else {
            return
        }
        let activationId = activationData[index].activationID
        acceptActivation(activationID: activationId)
    }
    
    func rejectTapped(at index: Int) {
        guard index >= 0 && index < activationData.count else {
            return
        }
        let activationId = activationData[index].activationID
        rejectActivation(activationID: activationId)
    }
    
    func activateNewLearnerTapped() {
        coordinator.goToActivationNewLearner()
    }
}

// MARK: - get Content requests -

extension ActivationViewModel {
    func fetchActivations() {
        do {
            activationData = .placeholder
            
            try getActivationsUseCase.execute()
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleContentRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleSecretriesCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            activationLoadingState = .failed
        }
    }
    
    func handleContentRequestsResult(activation: DomainWrapper<[Activations]>) {
        activationLoadingState = .loaded
        
        if activation.isSuccess, let activationData = activation.data {
            self.activationData = activationData
        } else {
            print(activation.message)
            showErrorToast(message: activation.message)
        }
    }
}

// MARK: - Accept requests -

extension ActivationViewModel {
    func acceptActivation(activationID: Int) {
        do {
            
            try acceptActivationUseCase.execute(activationID: activationID)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleContentRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleContentRequestsResult(activation: DomainWrapper<AcceptActivationResponse>) {
        activationLoadingState = .loaded
        
        if activation.isSuccess {
            showSuccessToast(message: activation.message)
            fetchActivations()
        } else {
            print(activation.message)
            showErrorToast(message: activation.message)
        }
    }
}

// MARK: - Accept requests -

extension ActivationViewModel {
    func rejectActivation(activationID: Int) {
        do {
            
            try rejectActivationUseCase.execute(activationID: activationID)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleContentRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleContentRequestsResult(activation: DomainWrapper<RejectActivationResponse>) {
        activationLoadingState = .loaded
        
        if activation.isSuccess {
            showSuccessToast(message: activation.message)
            fetchActivations()
        } else {
            print(activation.message)
            showErrorToast(message: activation.message)
        }
    }
}

// MARK: - Accept requests -

extension ActivationViewModel {
    func acceptAllActivation(activationID: [Int]) {
        do {
            
            try acceptAllActivationUseCase.execute(activationID: activationID)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleAcceptAllResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleAcceptAllResult(activation: DomainWrapper<AcceptActivationResponse>) {
        activationLoadingState = .loaded
        
        if activation.isSuccess {
            showSuccessToast(message: activation.message)
            fetchActivations()
        } else {
            print(activation.message)
            showErrorToast(message: activation.message)
        }
    }
}
