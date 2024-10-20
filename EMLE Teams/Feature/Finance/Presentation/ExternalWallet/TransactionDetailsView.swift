//
//  TransactionDetailsView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 21/07/2024.
//

import SwiftUI

import EMLECore

struct TransactionDetailsView: View {
    
    @StateObject var viewModel: TransactionDetailsViewModel
    
    init(transactionDetails:ExternalWallet,coordinator: TransactionDetailsCoordinting) {
        _viewModel = StateObject(wrappedValue: TransactionDetailsViewModel(transactionDetails: transactionDetails, coordinator: coordinator))
    }
    
    var body: some View {
        navigationBar
        MainView(viewModel: viewModel) {
            VStack(alignment: .leading, spacing: .sm) {
                secretaryView
                sectionItem(title: FinanceStrings.TransactionDate.localized, description: viewModel.transactionDetails.createdAtDate)
                sectionItem(title: FinanceStrings.phoneNumber.localized, description: viewModel.transactionDetails.enrollment.student.mobile)
                
                sectionItem(title: FinanceStrings.name.localized, description: viewModel.transactionDetails.enrollment.student.name)
                
                sectionItem(title: FinanceStrings.MaterialType.localized, description: viewModel.transactionDetails.contentType)
                
                sectionItem(title: FinanceStrings.materialName.localized, description: viewModel.transactionDetails.enrollment.content.name)
                
                sectionItem(title: FinanceStrings.typeOfEnrollment.localized, description: viewModel.transactionDetails.enrollment.enrollmentType?.title ?? "")
                
                sectionItem(title: FinanceStrings.progress.localized, description: viewModel.transactionDetails.progress)
                
                sectionItem(title: FinanceStrings.paidAmount.localized, description: viewModel.transactionDetails.amountWithCurrency)
                
            }
            .padding(.horizontal,.md)
            
            
            
        }
    }
}

extension TransactionDetailsView {
    
    private var navigationBar: some View {
        CustomNavigationBar.Checkout(title: FinanceStrings.transactionDetails.localized)
            .padding(.bottom,8)
            .customBackground(.container)
            .padding(.horizontal, .md)
    }
    
    private var secretaryInfoView: some View {
        HStack(spacing: .xxSm) {
            CustomImageView(image: viewModel.transactionDetails.receivable.image, placeholder: Image(systemName: "person.fill"))
                .frame(width: 28,height: 28)
                .clipShape(Circle())
            
            Text(viewModel.transactionDetails.receivable.name)
                    .customStyle(.bodySmall, .onSurface)
            Spacer()
        }
        .padding(.horizontal,.sm)
        .padding(.vertical,.xSm)
        
        .overlay {
            RoundedRectangle(cornerRadius: 6)
                .stroke( Color.neutral, lineWidth: 1)
        }
        
    }
    
    private var secretaryView: some View {
        VStack(alignment: .leading, spacing: .xSm){
            Text(FinanceStrings.secretary.localized)
                .customStyle(.bodySmall, .onSurface)
            secretaryInfoView
        }
    }
    
    private func sectionItem(title:String,description:String) ->  some View {
        VStack(alignment: .leading, spacing: .xSm){
            Text(title)
                .customStyle(.bodySmall, .onSurface)
            HStack(spacing: .xxSm) {
                Text(description)
                        .customStyle(.bodySmall, .neutral)
                Spacer()
            }
            .padding(.horizontal,.sm)
            .padding(.vertical,.xSm)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .customBackground(.container)
            
        }
    }
}

#Preview {
    TransactionDetailsView(transactionDetails: .placeholder, coordinator: TransactionDetailsCoordinator(navigationController: UINavigationController(), tabBarController:  MainTabBarController()))
}
