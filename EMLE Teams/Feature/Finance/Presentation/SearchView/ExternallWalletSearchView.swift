//
//  ExternallWalletSearchView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 19/08/2024.
//

import EMLECore
import SwiftUI

struct ExternallWalletSearchView: View {
    enum FocusedField {
        case searchBar
    }
    
    @FocusState var focusedField: FocusedField?
    @FocusState private var isDeclineTextFieldFocused: Bool

    let namespace: Namespace.ID
    let searchBarId: Namespace.ID
    @StateObject var viewModel: ExternalWalletViewModel
    
    private var closeAction: EmptyAction

    init(namespace: Namespace.ID,
         searchBarId: Namespace.ID,
         searchContentType: SearchContentType,
         closeAction: EmptyAction,
         coordinator: ExternalWalletCoordinating)
    {
        _viewModel = StateObject(wrappedValue: ExternalWalletViewModel(coordinator: coordinator))
        self.closeAction = closeAction
        self.namespace = namespace
        self.searchBarId = searchBarId
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            VStack(spacing: 0) {
                searchSearchBar
                    .padding(.horizontal, defaultHPadding)
                    .onTapGesture {
                        focusedField = .searchBar
                    }
                
                VStack(spacing: 0) {
                    
                    searchEnrollmentsResults
                    .redacted(viewModel.searchLoadingState)
                    
                    Spacer(minLength: 0)
                }
            }
        }
        .onTapGesture {
            focusedField = nil
        }
        .onAppear {
            focusedField = .searchBar
        }
    }
}

extension ExternallWalletSearchView {
    private var searchSearchBar: some View {
        SearchBar(searchText: $viewModel.searchText,
                  closeAction: {
                      closeAction?()
                  })
                  .focused($focusedField, equals: .searchBar)
                  .matchedGeometryEffect(id: searchBarId, in: namespace)
    }
    
    private var searchEnrollmentsResults: some View {
        SearchResultView(results: viewModel.searchExternalWalletResults,
                         contentType: .transactions,
                         selectAction: { transaction in
            viewModel.coordinator.goToTransactionDetails(transactionDetails: transaction.content)
        }) { _ in}
    }
}

#Preview {
    @Namespace var namespace
    @Namespace var searchBarId
    
    return ExternallWalletSearchView(namespace: namespace,
                      searchBarId: searchBarId,
                      searchContentType: .transactions,
                      closeAction: nil,
                      coordinator: ExternalWalletCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

extension ExternallWalletSearchView {
    
    @ViewBuilder
    private func textField(placeholder: String, value: Binding<String>, isFocused: FocusState<Bool>.Binding) -> some View {
        TextField(placeholder, text: value)
            .keyboardType(.numberPad)
            .focused(isFocused)
            .padding()
            .cornerRadius(.xBig)
            .overlay(
                RoundedRectangle(cornerRadius: .xBig)
                    .stroke(isFocused.wrappedValue ? Color.primaryColor : Color.neutral, lineWidth: 2)
                    .scaleEffect(isFocused.wrappedValue ? 1.02 : 1)
                    .animation(.easeOut(duration: 0.2), value: isFocused.wrappedValue)
            )
    }
}
