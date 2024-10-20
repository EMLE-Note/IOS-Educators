//
//  CustomDailogTextFieldViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 14/08/2024.
//

import Foundation
import EMLECore

class CustomDailogTextFieldViewModel: MainViewModel {
    let coordinator: CustomDailogTextFieldViewCoordinating

    init(coordinator: CustomDailogTextFieldViewCoordinating, model: CustomDialogTextFieldModel) {
        self.coordinator = coordinator
        self.model = model
    }
    
    var isCreateFolderButtonEnabled: Bool {
        !folderName.isEmpty
    }
    
    @Published var isActive: Bool = false
    @Published var model: CustomDialogTextFieldModel
    @Published var folderName: String = ""
}

extension CustomDailogTextFieldViewModel {
    func onAppear() {
        
    }
    
    func performAction() {
        handleAction(for: model.dialogType)
    }
    
    private func handleAction(for type: CustomDialogTextFieldType) {
        switch type {
        case .parent:
            createFolderParentTapped()
        case .lesson:
            createFolderLessonTapped()
        }
    }

    private func createFolderParentTapped() {
        print("createFolderParentTapped")
    }

    private func createFolderLessonTapped() {
        print("createFolderLessonTapped")
    }

    func cancelTapped() {
        coordinator.dismiss()
    }
}
