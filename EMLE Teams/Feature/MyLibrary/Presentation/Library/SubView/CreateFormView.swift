//
//  CreateFormView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 16/09/2024.
//

import Foundation
import SwiftUI
import EMLECore

struct CreateFormView: View {
    var headerTitle: String
    var headerSubtitle: String
    
    // Placeholders
    var identifierPlaceholder: String
    var titlePlaceholder: String
    var pricePlaceholder: String
    var overviewPlaceholder: String
    
    // Titles for the fields
    var identifierTitle: String
    var titleTitle: String
    var priceTitle: String
    var overviewTitle: String
    
    @Binding var identifier: String
    @Binding var title: String
    @Binding var price: String
    @Binding var overview: String
    
    var isIdentifierEnabled: Bool = true
    
    @State private var identifierIsValid = true
    
    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: headerTitle, subTitle: headerSubtitle)
            
            NoIndicatorsScrollView {
                
                CustomTextField(title: identifierTitle,
                                placeholder: identifierPlaceholder,
                                value: $identifier,
                                borderStateColor: identifierIsValid ? .neutral : .error)
                .disabled(!isIdentifierEnabled)
                .padding(.horizontal, .md)
                .onChange(of: identifier, perform: validateIdentifier)
                
                if !identifierIsValid {
                    Text(LibraryStrings.courseIdError.localized)
                        .customStyle(.caption2, .error)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, .md)
                }
                
                CustomTextField(title: titleTitle,
                                placeholder: titlePlaceholder,
                                value: $title,
                                borderStateColor: .neutral)
                .padding(.horizontal, .md)
                .padding(.vertical, .md)
                
                CustomTextField(title: priceTitle,
                                placeholder: pricePlaceholder,
                                value: $price,
                                borderStateColor: .neutral)
                .keyboardType(.numberPad)
                .padding(.horizontal, .md)
                .onChange(of: price, perform: updateCoursePrice)
                
                VStack(alignment: .leading) {
                    Text(overviewTitle)
                        .customStyle(.subheadline, .onSurface)
                    
                    CustomTextView(text: $overview,
                                   placeholder: overviewPlaceholder)
                }
                .padding(.horizontal, .md)
            }
        }
    }
    
    private func validateIdentifier(_ newValue: String) {
        let filteredIdentifier = newValue.filter { $0.isLetter || $0.isNumber }
        identifierIsValid = filteredIdentifier.count >= 4 && filteredIdentifier.count <= 10
        DispatchQueue.main.async {
            self.identifier = filteredIdentifier
        }
    }
    
    private func updateCoursePrice(_ newValue: String) {
        var validPrice = newValue.filter { "0123456789".contains($0) }
        
        while validPrice.hasPrefix("0") && validPrice.count > 1 {
            validPrice.removeFirst()
        }
        
        if validPrice == "0" {
            validPrice = ""
        }
        
        DispatchQueue.main.async {
            self.price = validPrice
        }
    }
}
