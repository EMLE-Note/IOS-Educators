//
//  SearchResultView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 15/08/2024.
//

import SwiftUI
import EMLECore

struct SearchResultView<T>: View {
    
    var results: [SearchResult<T>]
    var contentType:SearchContentType
    var selectAction: SearchResultDelegate<T> = nil
    var optionButtonClicked: SearchResultDelegate<T> = nil

    
    var body: some View {
        if results.count == 0 {
            
            noResult
                .padding(.top, 20)
                .padding(.horizontal, defaultHPadding)
        }
        else {
            
            NoIndicatorsScrollView {
                
                searchResultsList
                    .customContentPadding(.horizontal, defaultHPadding)
                    .customContentPadding(.top, 20)
                    .customContentPadding(.bottom, 16)
            }
            .customContentMargins(.horizontal, defaultHPadding)
            .customContentMargins(.top, 20)
            .customContentMargins(.bottom, 16)
        }
    }
    
    private var noResult: some View {
        switch contentType {
        case .transactions:
            return  emptyView(title: FinanceStrings.noTransactionsYet.localized, subtitle: FinanceStrings.noTransactionsMessage.localized)
        case .enrollments:
            return emptyView(title: FinanceStrings.noEnrollmentDebitsTitle.localized, subtitle: FinanceStrings.noEnrollmentDebitsMessage.localized)
        }
    }
    
    private var searchResultsList: some View {
        SearchResultsListView(results: results,
                              selectAction: selectAction,optionButtonClicked: optionButtonClicked)
    }
    
    private func emptyView(title:String, subtitle:String) -> some View {
        VStack(alignment: .center) {
            Image.emptyIcon
                .resizable()
                .frame(width: 120, height: 80)
            Text(title)
                .customStyle(.heading2, .onSurface)
            Text(subtitle)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .customStyle(.bodySmall, .subtitle)
        }
        .padding(.top,.xxxBig)
    }
}

#Preview {
    SearchResultView<ExternalWallet>(results: .placeholder, contentType: .transactions)
}
