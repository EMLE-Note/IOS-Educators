//
//  CountryListView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import SwiftUI
import CountryPicker
import EMLECore

struct CountryListView: View {
    
    var countries: [Country]
    var selectedIso: String
    
    var selectAction: SelectCountryDelegate = nil
    
    var body: some View {
        list
    }
    
    private var list: some View {
        ListView(dataArray: countries,
                 noDataSubMessage: RegistrationStrings.noCountries.localized) {
            countriesList
        }
    }
    
    private var countriesList: some View {
        VStack(spacing: 8) {
            ForEach(countries.indices, id: \.self) { index in
                CountryCellView(country: countries[index],
                                selectedIso: selectedIso,
                                selectAction: selectAction)
            }
        }
    }
}

#Preview {
    CountryListView(countries: [Country(isoCode: "EG"), Country(isoCode: "TR")], selectedIso: "EG")
}
