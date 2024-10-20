//
//  TransactionCardView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/08/2024.
//

import Foundation
import SwiftUI
import EMLECore

struct TransactionCardView: View {
    
    let externalWallet:ExternalWallet
    let isHaveOptionButton: Bool
    let onCardTapped: ()-> Void
    let onOptionButtonClicked: ()-> Void
    var selectAction: SearchResultDelegate<ExternalWallet> = nil

    
    
    var body: some View {
        transactionCardView(externalWallet: externalWallet)
    }
    
    private func studentInfoView(externalWallet: ExternalWallet) -> some View {
        HStack(spacing: .xxSm) {
            CustomImageView(image: externalWallet.enrollment.student.image, placeholder: Image(systemName: "person.fill"))
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: .no) {
                Text(externalWallet.enrollment.student.name)
                    .customStyle(.subheadline, .onSurface)
                Text(externalWallet.createdAtDate)
                    .customStyle(.caption1, .subtitle)
            }
            Spacer()
            if isHaveOptionButton {
                Button(action: {onOptionButtonClicked()}, label: {
                    Image.threeDots
                        .frame(width: 16, height: 16)
                })
            }
            
        }
    }
    
    private func typeOFEnrollmentSection(enrollment: Enrollment) -> some View {
        HStack {
            Text(FinanceStrings.typeOfEnrollment.localized)
                .customStyle(.bodySmall, .onSurface)
            Spacer()
            if let enrollmentType = enrollment.enrollmentType {
                Text(enrollmentType.title)
                    .customStyle(.caption1, .onPrimary)
                    .padding(.horizontal, .md)
                    .padding(.vertical, .xxSm)
                    .customBackground(enrollmentType.backgroundColor)
                    .clipShape(Capsule())
            }
        }
    }
    
    private func transactionCardItem(title: String, description: String) -> some View {
        HStack {
            Text(title)
                .customStyle(.bodySmall, .onSurface)
            Spacer(minLength: 50)
            Text(description)
                .lineLimit(1)
                .customStyle(.subheadline, .secondary)
        }
    }
    
    private func transactionCardView(externalWallet: ExternalWallet) -> some View {
                VStack {
                    studentInfoView(externalWallet: externalWallet)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    typeOFEnrollmentSection(enrollment: externalWallet.enrollment)
                    transactionCardItem(title: FinanceStrings.MaterialType.localized, description: externalWallet.contentType)
                    transactionCardItem(title: FinanceStrings.materialName.localized, description: externalWallet.enrollment.content.name)
                    transactionCardItem(title: FinanceStrings.paidAmount.localized, description: externalWallet.amountWithCurrency)
                }
                .padding(.vertical, .md)
                .padding(.horizontal, .xSm)
                .customBackground(.container)
                .customCornerRadii(.sm, corners: .allCorners)
                .shadow(color: .subtitleText.opacity(0.05), radius: 10, x: 0, y: -10)
                .onTapGesture {
                    onCardTapped()
                }
    }
    

}

#Preview {
    TransactionCardView(externalWallet: .placeholder, isHaveOptionButton: true, onCardTapped: {}, onOptionButtonClicked: {})
}
