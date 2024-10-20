//
//  CustomDialogViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 11/08/2024.
//

import Foundation
import EMLECore

class CustomDialogViewModel: MainViewModel {
    let coordinator: CustomDialogViewCoordinating

    init(coordinator: CustomDialogViewCoordinating, dialogType: CustomDialogType) {
        self.coordinator = coordinator
        self.model = CustomDialogModelConfigurator.configureModel(for: dialogType)
    }
    
    @Published var models: [CustomRadioPickerItemModel] = [] {
        didSet {
            if let firstItem = models.first {
                selectedModel = firstItem
            }
        }
    }
    
    @Published var selectedModel: CustomRadioPickerItemModel?
    
    func setupModels() {
        models = [
            CustomRadioPickerItemModel(displayName: "Option 1"),
            CustomRadioPickerItemModel(displayName: "Option 2")
        ]
    }
    
    @Published var model: CustomDialogModel
    @Published var isActive: Bool = false
}

extension CustomDialogViewModel {
    func onAppear() {
        
    }
    
    func performAction() {
        handleAction(for: model.dialogType)
    }
    
    private func handleAction(for type: CustomDialogType) {
        switch type {
        case .deleteFolder:
            handleDeletaFolderTapped()
        case .deleteCourse:
            handleDeleteCourseTapped()
        case .deactivateAll:
            handleDeactivateAllTapped()
        case .deactivateCourse:
            handleDeactivateCourseTapped()
        case .deactivateLearner:
            handleDeactivateLearnerTapped()
        }
    }

    private func handleDeletaFolderTapped() {
        print("handleDeletaFolderTapped")
    }

    private func handleDeleteCourseTapped() {
        print("handleDeleteCourseTappedd")
    }

    private func handleDeactivateAllTapped() {
        print("handleDeactivateAllTapped")
    }
    
    private func handleDeactivateCourseTapped() {
        print("handleDeactivateCourseTapped")
    }
    
    private func handleDeactivateLearnerTapped() {
        print("handleDeactivateLearnerTapped")
    }

    func cancelTapped() {
        coordinator.dismiss()
    }
}
