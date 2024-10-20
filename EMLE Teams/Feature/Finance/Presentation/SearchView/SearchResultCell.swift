//
//  SearchResultCell.swift
//  EMLE Teams
//
//  Created by iOSAYed on 15/08/2024.
//

import EMLECore
import SwiftUI

struct SearchResultCell<T>: View {
    var result: SearchResult<T>
    
    var selectAction: SearchResultDelegate<T> = nil
    var optionButtonClicked: SearchResultDelegate<T> = nil
    
    var body: some View {
        if selectAction != nil {
            button
        }
        else {
            resultItem
        }
    }
    
    private var button: some View {
        Button(action: {
            selectAction?(result)
        }, label: {
            resultItem
        })
    }
    
    private var resultItem: some View {
        HStack(spacing: 8) {
            if let result = result as? SearchResult<ExternalWallet> {
                let transaction = result.content
                TransactionCardView(externalWallet: transaction, isHaveOptionButton: false, onCardTapped: { selectAction?(self.result) }, onOptionButtonClicked: {})
            }
            
            if let result = result as? SearchResult<Enrollment> {
                let enrollment = result.content
                EnrollmentCardView(enrollment: enrollment, isHaveOptionButton: true, onCardTapped: { selectAction?(self.result) }, onOptionButtonClicked: { _ in
                    optionButtonClicked?(self.result)
                })
            }
        }
    }
}

#Preview {
    SearchResultCell<ExternalWallet>(result: .placeholder,optionButtonClicked: {_ in })
}
