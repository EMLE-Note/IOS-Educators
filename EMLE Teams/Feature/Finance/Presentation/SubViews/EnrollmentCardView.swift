//
//  EnrollmentCardView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import SwiftUI
import EMLECore

struct EnrollmentCardView: View {
    
    let enrollment:Enrollment
    let isHaveOptionButton: Bool
    let onCardTapped: ()-> Void
    let onOptionButtonClicked: (Enrollment)-> Void
    
    
    var body: some View {
        enrollmentCardView(enrollment: enrollment, materialType: FinanceStrings.courses.localized)
    }
    
    private func studentInfoView(enrollment: Enrollment) -> some View {
        HStack(spacing: .xxSm) {
            CustomImageView(image: enrollment.student.image, placeholder: Image(systemName: "person.fill"))
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: .no) {
                Text(enrollment.student.name)
                    .customStyle(.subheadline, .onSurface)
                Text(enrollment.createdAtDate)
                    .customStyle(.caption1, .subtitle)
            }
            Spacer()
            if isHaveOptionButton {
                Button(action: {onOptionButtonClicked(enrollment)}, label: {
                    Image.threeDots
                        .frame(width: 16, height: 16)
                })
            }
            
        }
    }
    
    private func typeOFEnrollmentSection(enrollment: Enrollment) -> some View {
        HStack {
            Text(FinanceStrings.enrollmentType.localized)
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
    
    private func enrollmentCardItem(title: String, description: String) -> some View {
        HStack {
            Text(title)
                .customStyle(.bodySmall, .onSurface)
            Spacer(minLength: 50)
            Text(description)
                .lineLimit(1)
                .customStyle(.subheadline, .secondary)
        }
    }
    
    private func enrollmentCardView(enrollment: Enrollment,materialType:String) -> some View {
                VStack {
                    studentInfoView(enrollment: enrollment)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    typeOFEnrollmentSection(enrollment: enrollment)
                    enrollmentCardItem(title: FinanceStrings.MaterialType.localized, description: materialType)
                    enrollmentCardItem(title: FinanceStrings.materialName.localized, description: enrollment.content.name)
                    enrollmentCardItem(title: FinanceStrings.progress.localized, description: enrollment.progress)
                    enrollmentCardItem(title: FinanceStrings.debitAmount.localized, description: enrollment.amountWithCurrency)
                }
                .padding(.vertical, .md)
                .padding(.horizontal, .xSm)
                .customBackground(enrollment.isDeactivate ? .neutral :.container )
                .customCornerRadii(.sm, corners: .allCorners)
                .shadow(color: .subtitleText.opacity(0.05), radius: 10, x: 0, y: -10)
                .onTapGesture {
                    onCardTapped()
                }
                .overlay {
                    if enrollment.isDeactivate {
                        RoundedRectangle(cornerRadius: .sm)
                            .stroke(Color.red, lineWidth: 1)
                    }
                }
    }
    

}

#Preview {
    TransactionCardView(externalWallet: .placeholder, isHaveOptionButton: true, onCardTapped: {}, onOptionButtonClicked: {})
}
