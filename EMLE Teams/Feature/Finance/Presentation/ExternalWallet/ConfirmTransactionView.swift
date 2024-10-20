//
//  ConfirmTransactionView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 05/08/2024.
//

import EMLECore
import SwiftUI

struct ConfirmTransactionView: View {
    @StateObject var viewModel: ConfirmTransactionViewModel

    init(coordinator: ConfirmTransactionCoordinating) {
        _viewModel = StateObject(wrappedValue: ConfirmTransactionViewModel(coordinator: coordinator))
    }

    @State private var isShowingFullImage = false

    var body: some View {
        VStack {
            navigationBar
            MainView(viewModel: viewModel) {
                if viewModel.transactionsRequestsList.isEmpty {
                    empty
                }else {
                    transactionRequestCard
                }
            }
        }
        .withLoaderOnTopOfView(isLoading: $viewModel.TransactionActionsLoadingState)

        .overlay(
            Group {
                if isShowingFullImage, let imageURL = viewModel.selectedImageURL {
                    FullScreenImageView(isShowingFullImage: $isShowingFullImage, imageUrl: imageURL)
                        .transition(.asymmetric(insertion: .scale(scale: 1.8).combined(with: .opacity), removal: .opacity))
                }
            }
            .ignoresSafeArea()
        )
    }

    private var navigationBar: some View {
        CustomNavigationBar.Checkout(title: FinanceStrings.confirmTransactions.localized)
            .padding(.bottom, 8)
            .customBackground(.container)
            .padding(.horizontal, .md)
    }

    private var transactionRequestCard: some View {
        VStack(spacing: .xxSm) {
            NoIndicatorsScrollView {
                ForEach(viewModel.transactionsRequestsList, id: \.self) { request in
                    VStack(alignment: .leading) {
                        studentInfoView(transactionRequst: request)
                        transactionRequestDetails(transactionRequst: request)
                        transactionRequestButtons(tranactionRequestId: request.transactionId)
                    }
                    .padding()
                    Divider()
                }
            }
        }
    }

    private func studentInfoView(transactionRequst: TransactionRequests) -> some View {
        HStack(spacing: .xxSm) {
            CustomImageView(image: transactionRequst.staff.image, placeholder: Image(systemName: "person.fill"))
                .frame(width: 32, height: 32)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: .no) {
                Text(transactionRequst.staff.name)
                    .customStyle(.subheadline, .onSurface)
                Text(transactionRequst.createdAtDate)
                    .customStyle(.caption1, .subtitle)
            }
        }
    }

    private func transactionRequestDetails(transactionRequst: TransactionRequests) -> some View {
        HStack {
            Text("\(FinanceStrings.pleaseConfirmReceiving.localized) \(transactionRequst.amountWithCurrency)")
                .customStyle(.bodySmall, .onSurface)
            Spacer()
            Button(action: {
                if let imageUrl = transactionRequst.image {
                    viewModel.selectedImageURL = imageUrl
                    withAnimation(.spring()) {
                        isShowingFullImage = true
                    }
                } else {
                    showToast(message: FinanceStrings.noImageAttached.localized)
                }
            }, label: {
                CustomImageView(image: transactionRequst.image, placeholder: Image(systemName: "photo.fill"), contentMode: .fill)
                    .customCornerRadii(.xSm, corners: .allCorners)
                    .frame(width: 124, height: 55)
            })
        }
    }

    private func transactionRequestButtons(tranactionRequestId:Int)-> some View {
        HStack {
            Spacer()
            PrimaryButton(title: FinanceStrings.decline.localized, action: { viewModel.didClickDecline(tranactionRequestId:tranactionRequestId) }, height: 30, backgroundColor: .neutral)
                .customStyle(.bodySmall, .container)
                .clipShape(Capsule())
                .frame(width: 100)
            PrimaryButton(title: FinanceStrings.confirm.localized, action: { viewModel.didClickConfirm(tranactionRequestId:tranactionRequestId) }, height: 30, backgroundColor: .secondary)
                .customStyle(.bodySmall, .container)
                .clipShape(Capsule())
                .frame(width: 100)
        }
    }
    
    private var empty: some View {
        VStack(alignment: .center) {
            Image.emptyIcon
                .resizable()
                .frame(width: 120, height: 80)
            Text("No Transactions Requests Yet")
                .customStyle(.heading2, .onSurface)
            Text("Any Request's transactions\nwill appear here.")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .customStyle(.bodySmall, .subtitle)
        }
    }
}

#Preview {
    ConfirmTransactionView(coordinator: ConfirmTransactionCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}
