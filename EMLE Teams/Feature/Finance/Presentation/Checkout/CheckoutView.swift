//
//  CheckoutView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/07/2024.
//

import SwiftUI
import EMLECore

struct CheckoutView: View {
    @StateObject var viewModel: CheckoutViewModel
    @State private var selectedPaymentMethod: Int? = 0 {
        didSet {
            if let selectedPaymentMethodId = selectedPaymentMethod{
                viewModel.paymenId = selectedPaymentMethodId
            }
        }
    }
    @State private var showBalanceCard: Bool = false

    init(dataFromFinance: DataPassedToCheckout, coordinator: CheckoutViewCoordinating) {
        _viewModel = StateObject(wrappedValue: CheckoutViewModel(dataFromFinance: dataFromFinance, coordinator: coordinator))
    }
    
    var body: some View {
        navigationBar
        MainView(viewModel: viewModel) {
            NoIndicatorsScrollView {
                VStack {
                    topSection()
                   switch viewModel.paymentCallBackResult {
                   case .success:
                       Text("Payment Result: success")
                   case .failure:
                       Text("Payment Result: failure")
                   case .unknown:
                       Text("Payment Result: unknown")
                   case .none:
                       EmptyView()
                   }
                    
                    VStack {
                        ForEach(viewModel.paymentMethods, id: \.self) { method in
                            PaymentMethodItemView(
                                image: .paymobLogo,
                                name: method.name,
                                description: "",
                                isSelected: selectedPaymentMethod == method.id
                            )
                            .onTapGesture {
                                if selectedPaymentMethod == method.id {
                                    selectedPaymentMethod = 0
                                } else {
                                    selectedPaymentMethod = method.id
                                }
                                withAnimation {
                                    showBalanceCard = selectedPaymentMethod == -1
                                }
                            }
                        }
                        
                        if showBalanceCard {
                            myBalanceCard(balance: viewModel.myBalance)
                        }
                    }
                    .padding()
                }
                .padding(.vertical)
            }
            
            payBillButton(totalPayment: viewModel.totalToPay, disabled: selectedPaymentMethod == 0, payBill: viewModel.ProceedToPayClicked)
            
            
        }
       
        
        
        .onAppear {
            viewModel.onAppear()
        }
        .withLoadingState(loadingState: viewModel.payByGetwayLoadingState)
    }
    
    private var navigationBar: some View {
        CustomNavigationBar.Checkout(title: "Checkout")
            .padding(.bottom, 8)
            .customBackground(.surface)
            .padding(.horizontal, defaultHPadding)
    }
    
    private func topSection() -> some View {
        VStack(alignment: .leading) {
            Text("Choose your payment method")
                .customStyle(.headline, .onSurface)
            
            Text("Save now and get 20% Off Instantly when you pay with your credit card ")
                .customStyle(.bodySmall, .subtitle)
                .lineLimit(3)
        }
        .padding(.vertical, 8)
    }
    
    private func payBillButton(totalPayment: String, disabled: Bool, payBill action: EmptyAction) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text("Total payment")
                    .customStyle(.buttonText, .subtitle)
                
                Spacer()
                
                Text(totalPayment)
                    .customStyle(.buttonText, .onSurface)
            }
            .padding()
            
            PrimaryButton(title: "Proceed to pay", action: action)
                .disabled(disabled)
                .padding(.horizontal)
        }
        .customBackground(.onPrimary)
        .customCornerRadii(20, corners: [.topLeft, .topRight])
    }
    
    private func myBalanceCard(balance: String) -> some View {
        HStack(alignment: .center) {
            Text("Your current balance is")
                .customStyle(.subheadline, .onPrimary)
            
            Spacer()
            
            Text(balance)
                .customStyle(.headline, .onPrimary)
        }
        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 55)
        .padding()
        .customBackground(.primary)
        .customCornerRadius(12)
    }
}

#Preview {
    CheckoutView(
        dataFromFinance: .placeholder,
        coordinator: CheckoutViewCoordinator(
            navigationController: UINavigationController(),
            tabBarController: MainTabBarController()
        )
    )
}
