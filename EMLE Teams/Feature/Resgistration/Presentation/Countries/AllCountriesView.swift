//
//  AllCountriesView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import SwiftUI
import CountryPicker
import EMLECore

struct AllCountriesView: View {
    
    @StateObject var viewModel: AllCountriesViewModel
    
    var selectCountryAction: SelectCountryDelegate = nil
    
    init(selectedCountryIso: String, selectCountryAction: SelectCountryDelegate = nil) {
        
        _viewModel = StateObject(wrappedValue: AllCountriesViewModel(selectedCountryIso: selectedCountryIso))
        
        self.selectCountryAction = selectCountryAction
    }
    
    var body: some View {
        VStack(spacing: 8) {
            
            header
            
            searchBar
            
            list
                .padding(.horizontal, 16)
        }
        .onAppear { viewModel.onApper() }
        .padding(.top, 13)
    }
    
    private var header: some View {
        SheetHeader(title: RegistrationStrings.selectYourCountry.localized)
    }
    
    private var searchBar: some View {
        SearchBar(searchText: $viewModel.searchText)
    }
    
    private var list: some View {
        ScrollView(showsIndicators: false) {
            
            CountryListView(countries: viewModel.filteredCountries,
                            selectedIso: viewModel.selectedCountryIso,
                            selectAction: selectCountryAction)
        }
    }
}

#Preview {
    AllCountriesView(selectedCountryIso: "TR")
}
