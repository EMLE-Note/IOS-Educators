//
//  QBankFirstStepView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct QBankFirstStepView: View {
    @ObservedObject var viewModel: AddQBankViewModel

    var body: some View {
        VStack(alignment: .leading) {
            
            NoIndicatorsScrollView {
                
                CreateFormView(
                    headerTitle: viewModel.addQBankSteps.headerTitle,
                    headerSubtitle: viewModel.addQBankSteps.headerSubtitle,
                    identifierPlaceholder: LibraryStrings.qbankIdPH.localized,
                    titlePlaceholder: LibraryStrings.qbankTitlePH.localized,
                    pricePlaceholder: LibraryStrings.qbankPricePH.localized,
                    overviewPlaceholder: LibraryStrings.qbankOverviewPH.localized,
                    identifierTitle: LibraryStrings.qbankId.localized,
                    titleTitle: LibraryStrings.qbankTitle.localized,
                    priceTitle: LibraryStrings.qbankPrice.localized,
                    overviewTitle: LibraryStrings.qbankId.localized,
                    identifier: $viewModel.qbankId,
                    title: $viewModel.qbankTitle,
                    price: $viewModel.qbankPrice,
                    overview: $viewModel.qbankOverview
                )
                
                showPriceAndStudentCountView
            }
        }
    }
}

// MARK: - Show price and student Count

extension QBankFirstStepView {
    private var showPriceAndStudentCountView: some View {
        HStack {
            VStack(alignment: .leading, spacing: .sm) {
                CustomCheckBox(isOn: $viewModel.isShowPrice, title: "Show Ptice")
                CustomCheckBox(isOn: $viewModel.isShowStudentCount, title: "Show Student Count")
            }
            
            Spacer()
        }
        .padding(.horizontal, .md)
    }
}
