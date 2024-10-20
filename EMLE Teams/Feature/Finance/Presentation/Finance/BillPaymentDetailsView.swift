//
//  BillPaymentDetailsView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import SwiftUI
import EMLECore

struct BillPaymentDetailsView: View {
    @StateObject var viewModel:BillPaymentDetailsViewModel
    
    init(currentBills:Bills ,coordinator: BillPaymentDetailsCoordinating) {
        _viewModel = StateObject(wrappedValue: BillPaymentDetailsViewModel(currentBill: currentBills, coordinator: coordinator))
    }
    
    var body: some View {
        navigationBar
        MainView(viewModel: viewModel) {
            NoIndicatorsScrollView {
                VStack {
                    topSection(total: viewModel.currentBills.total?.stringTwoDecimalDigit ?? "", currancy: viewModel.currentBills.current?.currency?.code ?? "", month: viewModel.currentBills.current?.createdAtMonth ?? "", dueDate: viewModel.currentBills.current?.billDueDateWithDash ?? "", status: viewModel.currentBills.current?.billState ?? .overDue)
                    if let billDetails = viewModel.currentBills.current?.data {
                        BillDetailsView(monitorBill:billDetails )
                    }
                }
                .padding(.vertical)
            }
            payBillButton(payBill: viewModel.payBillClicked)
        }
       
        
    }
    
    private var navigationBar: some View {
        CustomNavigationBar.Checkout(title: "Bill Payment")
            .padding(.bottom,8)
            .customBackground(.surface)
            .padding(.horizontal, defaultHPadding)
    }
    
    private func topSection(total:String,currancy:String,month:String,dueDate:String,status:BillStates) -> some View{
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Total bill")
                Spacer()
                Text("\(total) \(currancy)")
                    .fontWeight(.bold)
            }
            HStack {
                Text("Issued month")
                Spacer()
                Text(month)
            }
            HStack {
                Text("Due date")
                Spacer()
                Text(dueDate)
            }
            HStack {
                Text("Status")
                Spacer()
                Text(status.title)
                    .foregroundColor(.white)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .background(status.backgroundColor)
                    .clipShape(.capsule)
            }
        }
        .padding()
        .customBackground(.surface)
        .customCornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 15, x: 0, y: 15)
        .padding(.horizontal)
    }
    
    private func payBillButton(payBill action: EmptyAction) -> some View {
        VStack(spacing: 16) {
            PrimaryButton(title: "Pay Now",action: action)
        }
        .padding(.horizontal,defaultHPadding)
    }
}

#Preview {
    BillPaymentDetailsView(currentBills: .placeholder, coordinator: BillPaymentDetailsCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
}
