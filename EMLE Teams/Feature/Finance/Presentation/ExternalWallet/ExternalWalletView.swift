//
//  ExternalWalletView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 18/07/2024.
//

import EMLECore
import SwiftUI

struct ExternalWalletView: View {
    @Namespace private var namespace
    @Namespace private var searchBarId
    
    @StateObject var viewModel: ExternalWalletViewModel

    init(coordinator: ExternalWalletCoordinating) {
        _viewModel = StateObject(wrappedValue: ExternalWalletViewModel(coordinator: coordinator))
    }

    var body: some View {
        switch viewModel.screenType {
        case .content:
            externalWalletView
        case .filters:
            filterView
        case .search:
            searchView
        }
    }
}

extension ExternalWalletView {
    @ViewBuilder
    private var externalWalletView: some View {
        navigationBar
        MainView(viewModel: viewModel) {
            VStack(alignment: .center, spacing: .big) {
                confirmTransactionsView(onClicked: viewModel.onClickedOnConfirmTransactions, requestsCount: viewModel.transactionRequestCount)
                    .padding()
                transactionsView
                searchBarView
                if !viewModel.isShowEmptyView {
                    paginatedBody
                } else {
                    empty
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
    
    private var paginatedBody: some View {
        PaginationView(canGetANewPage: viewModel.TransactionsData.canGetANewPage,
                       getNewPageAction: viewModel.getNewTransactions)
        {
            transactionCardsView(externalWallets: viewModel.TransactionsData.pageContent)
                .redacted(viewModel.externalWalletLoadingState)
                .withShimmerOverlay()
        }
        
//        .withLoaderOrView(isLoading: $viewModel.externalWalletLoadingState)
    }
    
    @ViewBuilder
    private var filterView: some View {
        TransactionsFilterView(filters: $viewModel.filterOptions, closeAction: viewModel.onFiltersClose)
    }
    
    @ViewBuilder
    private var searchView: some View {
        ExternallWalletSearchView(namespace: namespace, searchBarId: searchBarId, searchContentType: .enrollments, closeAction: viewModel.onSearchBarCloseClick, coordinator: viewModel.coordinator)
    }
    private var navigationBar: some View {
        CustomNavigationBar.Checkout(title: FinanceStrings.externalWallet.localized)
            .padding(.bottom, 8)
            .customBackground(.container)
            .padding(.horizontal, defaultHPadding)
    }
    
    private func confirmTransactionsView(onClicked: EmptyAction, requestsCount: Int) -> some View {
        VStack(alignment: .leading) {
            Button(action: {
                onClicked?()
            }, label: {
                HStack {
                    Text(FinanceStrings.confirmTransactions.localized)
                        .customStyle(.subheadline, .onSurface)
                    
                    Spacer()
                    Image.chevronForward
                        .customStyle(.headline, .neutral)
                }
            })
            Text("\(requestsCount) \(FinanceStrings.requests.localized)")
                .customStyle(.caption1, .error)
        }
        .padding()
        .customBackground(.container)
        .customCornerRadius(12)
        .shadow(color: .onSurface.opacity(0.05), radius: 15, x: 0, y: 15)
    }
    
    private var transactionsView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(FinanceStrings.transactions.localized)
                    .customStyle(.headline, .onSurface)
                Spacer()
            }
            
            if !viewModel.secretariesList.isEmpty {
                NoIndicatorsScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.secretariesList, id: \.self) { secretary in
                            HStack(spacing: .xxSm) {
                                let placeholderImage = Image(systemName: "person.fill")
                                    .resizable()
                            
                                CustomImageView(image: secretary.image, placeholder: placeholderImage)
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                            
                                VStack(alignment: .leading, spacing: .no) {
                                    Text(secretary.name)
                                        .customStyle(.bodySmall, .onSurface)
                                    Text("\(secretary.balance.stringTwoDecimalDigit) \(viewModel.currancyCode)")
                                        .customStyle(.subheadline, .onSurface)
                                }
                            }
                            .padding(.xSm)
                            .customBackground(viewModel.selectedTransactionId == secretary.SecretaryId ? .primary : .container)
                            .customCornerRadius(.sm)
                            .shadow(color: .black.opacity(0.05), radius: 15, x: 0, y: 15)
                            .onTapGesture {
                                viewModel.onSelectedTransaction(transactionId: secretary.SecretaryId)
                            }
                        }
                    }
                }
            }
        }
        .padding(.xSm)
    }
    
    private var searchBarView: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                transactionSearchBar
                filtersButton
            }
        }
        .padding(.horizontal, defaultHPadding)
    }
    
    private var transactionSearchBar: some View {
        SearchBar(searchText: $viewModel.searchText)
            .matchedGeometryEffect(id: searchBarId, in: namespace)
            .frame(height: 50)
            .background {
                RoundedRectangle(cornerRadius: .xSm)
                    .customStroke(.neutral)
            }
            .onTapGesture {
                viewModel.onSearchBarClicked()
            }
    }
    
    private var filtersButton: some View {
        PrimaryImageButton(image: .filters,
                           action: viewModel.onFiltersClicked)
    }
    
    private func transactionCardsView(externalWallets: [ExternalWallet]) -> some View {
        NoIndicatorsScrollView {
            ForEach(externalWallets, id: \.self) { externalWallet in
                TransactionCardView(externalWallet: externalWallet, isHaveOptionButton: false) 
                {
                    viewModel.onClickedTransactionCard(transaction: externalWallet)
                } onOptionButtonClicked: {}
            }
        }
        .padding(.sm)
    }
    
    private var empty: some View {
        VStack(alignment: .center) {
            Image.emptyIcon
                .resizable()
                .frame(width: 120, height: 80)
            Text("No Transactions Yet")
                .customStyle(.heading2, .onSurface)
            Text("Any enrollment’s transactions\nwill appear here.")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .customStyle(.bodySmall, .subtitle)
        }
    }
}

#Preview {
    ExternalWalletView(
        coordinator: ExternalWalletCoordinator(
            navigationController: UINavigationController(),
            tabBarController: MainTabBarController()
        ))
}
