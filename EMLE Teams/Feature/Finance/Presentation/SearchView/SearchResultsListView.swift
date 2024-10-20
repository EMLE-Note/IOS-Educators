//
//  SearchResultsListView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 15/08/2024.
//

import Foundation
import SwiftUI

struct SearchResultsListView<T>: View {
    
    var results: [SearchResult<T>]
    
    var selectAction: SearchResultDelegate<T> = nil
    var optionButtonClicked: SearchResultDelegate<T> = nil

    var body: some View {
        list
    }
    
    private var list: some View {
        VStack(spacing: 12) {
            
            ForEach(results) { result in
                
                SearchResultCell(result: result,
                                 selectAction: selectAction,optionButtonClicked: optionButtonClicked)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SearchResultsListView<ExternalWallet>(results: .placeholder)
}
