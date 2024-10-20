//
//  CountryCellView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import SwiftUI
import CountryPicker
import EMLECore

struct CountryCellView: View {
    
    var country: Country
    var selectedIso: String
    
    var selectAction: SelectCountryDelegate = nil
    
    var selected: Bool { selectedIso == country.isoCode }
    
    var body: some View {
        Button {
            selectAction?(country)
        } label: {
            content
        }
    }
    
    private var content: some View {
        VStack(spacing: 8) {
            
            CustomDivider()
            
            HStack {
                name
                
                Spacer()
                
                phoneCode
            }
        }
    }
    
    private var name: some View {
        Text(country.localizedName)
            .customFont(size: 14, weight: ._500, lineHeight: 16)
            .customForeground(.onSurface)
            .lineLimit(1)
    }
    
    private var phoneCode: some View {
        Text(RegistrationStrings.phoneCodeSS.localizedFormat(arguments: country.isoCode.getFlag(), "+\(country.phoneCode)"))
            .customFont(size: 14, weight: ._500, lineHeight: 16)
            .customForeground(.onSurface)
            .lineLimit(1)
            .padding(6)
            .customBackground(selected ? .primary : .clear)
            .customCornerRadius(5)
    }
}

#Preview {
    CountryCellView(country: Country(isoCode: "EG"), selectedIso: "EG")
}
