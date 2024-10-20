//
//  EditQuestionView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/09/2024.
//

import SwiftUI
import EMLECore

struct EditQuestionView: View {
    
    @StateObject var viewModel: EditQuestionViewModel
    
    init(queationId: Int, coordinator: QBankViewCoordinating) {
        _viewModel = StateObject(wrappedValue: EditQuestionViewModel(coordinator: coordinator, queationId: queationId))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            
            editView
            
            Spacer()
        }
    }
}

// Preview for SwiftUI View
struct EditQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        EditQuestionView(queationId: 0, coordinator: QBankViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
    }
}

extension EditQuestionView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: LibraryStrings.editQuestionBank.localized)
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
            
        }
        .customBackground(.container)
        .padding(.bottom, .xxSm)
    }
}

extension EditQuestionView {
    private var editView: some View {
        VStack {
            EditView(title: LibraryStrings.qbankSettings.localized, action: { viewModel.qbankSettingTapped() })
            EditView(title: LibraryStrings.question.localized, action: { viewModel.queationTapped() })
        }
        .padding()
    }
}
