//
//  FinanceView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 28/06/2024.
//

import SwiftUI
import EMLECore

struct FinanceView: View {
    @StateObject var viewModel: FinanceViewModel

    init(coordinator: FinanceViewCoordinating) {
        _viewModel = StateObject(wrappedValue: FinanceViewModel(coordinator: coordinator))
    }

    var body: some View {
        VStack {
            if viewModel.noDataMessage.isEmpty {
                financeBody
            }else {
                noDataView
            }
        }
        
    }
    
    @ViewBuilder
    private var financeBody: some View {
        headerView(balance: viewModel.balance.stringTwoDecimalDigit, currancy: viewModel.currancy.code ?? "", chargeBalance: viewModel.onClickedOnBalance)
        MainView(viewModel: viewModel) {
            NoIndicatorsScrollView {
                VStack(spacing: 20) {
                    availableWalletsBalance(Wallet: viewModel.wallet, debits: viewModel.depits, currency: viewModel.currancy.code ?? "", viewModel: viewModel)
                    BillSummaryView(message: viewModel.alertMessage, state: viewModel.billState, backgroundColors: viewModel.billState.gradiantBackground, progressRate: viewModel.getProgressRate(balanceUsed: viewModel.balanceUsed), balanceUsed: viewModel.balanceUsed, total: viewModel.bills.total?.stringTwoDecimalDigit ?? "", currantBill: viewModel.currentBill, onClickedOnBillCard: viewModel.onClickedOnBillCard, onClickedOnPayNow: viewModel.onClickedOnPayNow)
                    paymentHistoryView(onClicked: viewModel.onClickedOnPaymentHistory)

                    if let monitorBill = viewModel.currentBill.data, let tokens = viewModel.currentBill.data?.tokens {
                        monitorBillView(monitorBill: monitorBill, tokens: tokens)
                    }
                }
                .padding()
            }
        }
        .customSheet(isPresented: $viewModel.isBalanceRechargeViewPresented, height: 150, detents: [.medium], content: {
            getSheetView {
                balancePopupView(balance: viewModel.balance.stringTwoDecimalDigit, currancy: viewModel.currancy.code ?? "", chargeBalance:viewModel.rechargeBalanceOnClicked)
            }
        })

        .withLoadingState(loadingState: viewModel.getFinanceLoadingState)
        
    }
    
    
    private var noDataView: some View {
        VStack {
            Text(viewModel.noDataMessage)
                .customStyle(.bodyMedium, .onSurface)
            
            Button {
                viewModel.onAppear()
            } label: {
                Text("Retry")
            }

        }
    }

    private var sheetGrapper: some View {
        Capsule()
            .customFill(.primary)
            .frame(width: 32, height: .xxSm)
    }

    private func getSheetView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        VStack {
            Spacer()
            sheetGrapper
            VStack(spacing: 8) {
                content()
            }
            .padding(.horizontal, defaultHPadding)
            .padding(.top, 12)
            .padding(.bottom, 32)
            .customBackground(.container)
            .customCornerRadii(.xxxBig, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FinanceView(coordinator: FinanceViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}

private func headerView(balance: String, currancy: String, chargeBalance action: EmptyAction) -> some View {
    HStack {
        Text("Finance")
            .customStyle(.subheadline, .onSurface)
        
        Spacer()
        
        HStack {
            Button(action: {
                       action?()
                   },
                   label: {
                       HStack {
                           Image(.dollarImg)
                           Text("\(balance) \(currancy)")
                               .customStyle(.subheadline, .onSurface)
                       }
                   })
        }
    }
    .padding(.bottom, 16)
    .customBackground(.container)
    .padding(.horizontal, defaultHPadding)
}

private func availableWalletsBalance(Wallet: Double, debits: Double, currency: String,viewModel:FinanceViewModel) -> some View {
    HStack {
        WalletView(amount: Wallet, description: "Secretary Wallet", currency: currency, onClicked: viewModel.onClickedOnWallet)
        WalletView(amount: debits, description: "Enrollment Debits", currency: currency, onClicked: viewModel.onClickedOnEnrollment)
    }
}

private func WalletView(amount: Double, description: String, currency: String, onClicked:EmptyAction) -> some View {
    VStack {
        Text("\(amount, specifier: "%.0f") EGP")
            .customStyle(.headline, .secondary)
        
        Text(description)
            .customStyle(.bodySmall, .onSurface)
    }
    .onTapGesture {
        onClicked?()
    }
    .frame(maxWidth: .infinity)
    .padding()
    .customBackground(.container)
    .customCornerRadius(12)
    .shadow(color: .onSurface.opacity(0.05), radius: 15, x: 0, y: 15)
}

private func paymentHistoryView(onClicked: EmptyAction) -> some View {
    VStack(alignment: .leading) {
        Button(action: {}, label: {
            HStack {
                Text("Payment History")
                    .customStyle(.subheadline, .onSurface)
                
                Spacer()
                Image.chevronForward
                    .customForeground(.onSurface)
            }
        })
    }
    .padding()
    .customBackground(.container)
    .customCornerRadius(12)
    .shadow(color: .onSurface.opacity(0.05), radius: 15, x: 0, y: 15)
}

private func monitorBillView(monitorBill: MonitorBill, tokens: TokenItem) -> some View {
    VStack(alignment: .leading, spacing: 10) {
        Text("Monitor Your Bill")
            .customStyle(.headline, .onSurface)
        
        HStack {
            if let students = monitorBill.students {
                BillMonitorItemView(title: "Students", count: students.value?.stringTwoDecimalDigit ?? "", amount: students.amount)
            }

            if let tokens = monitorBill.tokens {
                BillMonitorItemView(title: "Tokens", count: nil, amount: tokens.amount)
            }
        }
        HStack {
            if let storage = monitorBill.storage {
                BillMonitorItemView(title: "Storage", count: storage.value?.stringTwoDecimalDigit ?? "" , amount: storage.amount)
            }
            if let bandwidth = monitorBill.bandwidth {
                BillMonitorItemView(title: "Bandwidth", count: bandwidth.value?.stringTwoDecimalDigit ?? "" , amount: bandwidth.amount)
            }
        }
    }
}

private func balancePopupView(balance: String, currancy: String, chargeBalance action: EmptyAction) -> some View {
    VStack(alignment:.leading,spacing: 16) {
        Text("Your balance")
            .customStyle(.subheadline, .onSurface)
        
        HStack {
            Image(.dollarImg)
            Text("\(balance) \(currancy)")
                .customStyle(.headline, .onSurface)
            
        }
        
        PrimaryButton(title: "Recharge balance",
                      action: action,
                      leadingIcon: .moneyImage)
    }
    .padding(.horizontal,8)
    .customBackground(.container)
}
