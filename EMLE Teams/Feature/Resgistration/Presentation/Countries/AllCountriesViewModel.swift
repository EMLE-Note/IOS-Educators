//
//  AllCountriesViewModel.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import Foundation
import EMLECore
import CountryPicker

typealias SelectCountryDelegate = ((Country) -> Void)?

final class AllCountriesViewModel: ObservableObject {
    
    @Published var countries: [Country] = []
    @Published var filteredCountries: [Country] = []
    
    @Published var searchText: String = "" {
        didSet {
            filterCountries()
        }
    }
    
    var selectedCountryIso: String
    
    init(selectedCountryIso: String) {
        self.selectedCountryIso = selectedCountryIso
    }
}

extension AllCountriesViewModel {
    
    func onApper() {
        
        getCountries()
    }
}

extension AllCountriesViewModel {
    
    private func getCountries() {
        countries = CountryManager.shared.getCountries().sorted {
            $0.localizedName.localizedCaseInsensitiveCompare($1.localizedName) == CountryManager.shared.config.countriesSortingComparisonResult
        }
        
        filteredCountries = countries
    }
    
    private func filterCountries() {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries
                .filter { $0.localizedName.localizedLowercase.contains(searchText.localizedLowercase) }
        }
    }
}
