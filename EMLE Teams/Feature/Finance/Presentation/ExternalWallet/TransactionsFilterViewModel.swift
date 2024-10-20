//
//  TransactionsFilterViewModel.swift
//  EMLE Teams
//
//  Created by iOSAYed on 26/07/2024.
//

import EMLECore
import Foundation
import SwiftUI

final class TransactionsFilterViewModel: MainViewModel {
    @Binding private var filters: TransactionFilterOptions
    @Published var displayedFilters: TransactionFilterOptions
    
    var isClearButtonDisabled: Bool { !isFilterSelected }
    var isFilterSelected: Bool {
        displayedFilters.isSelected
    }
    
    var isTabBarVisible: Bool { false }
    private var closeAction: EmptyAction
    
    init(filters: Binding<TransactionFilterOptions>, closeAction: EmptyAction) {
        self._filters = filters
        self.closeAction = closeAction
        
        displayedFilters = filters.wrappedValue
        preprerStarterFilters()
    }

    @Published var selectedDateOption: DateFilterOptions? = nil {
        didSet {
            preprerSelectedFilters()
        }
    }

    @Published var selectedAmountOption: AmountFilterOptions? = nil {
        didSet {
            preprerSelectedFilters()
        }
    }

    @Published var selectedEnrollmentTypes: Set<EnrollmentTypeFilterOptions> = [] {
        didSet {
            preprerSelectedFilters()
        }
    }
    @Published var selectedMaterialTypes: Set<MaterialTypeFilterOptions> = []{
        didSet {
            preprerSelectedFilters()
        }
    }
    @Published var minAmount: String = ""{
        didSet {
            preprerSelectedFilters()
        }
    }
    @Published var maxAmount: String = ""{
        didSet {
            preprerSelectedFilters()
        }
    }
}

extension TransactionsFilterViewModel {
    func onAppear() {}
    
    func onFilterClosed() {
        dismiss()
    }
    
    private func dismiss() {
        closeAction?()
    }
    
    func onApplyClick() {
        applyFilters()
        dismiss()
    }

    func onClearClick() {
        clearFilters()
    }
}

extension TransactionsFilterViewModel {
    
    private func clearFiltersPublished(){
        selectedDateOption = nil
         selectedAmountOption = nil
         selectedEnrollmentTypes = []
         selectedMaterialTypes = []
         minAmount = ""
         maxAmount = ""
    }
    private func clearFilters() {
        if displayedFilters.isSelected {
            clearFiltersPublished()
            filters = .empty
            displayedFilters = .empty
            
        }
    }
        
    private func applyFilters() {
        preprerSelectedFilters()
        filters = displayedFilters
    }
    private func preprerStarterFilters() {
         minAmount = filters.minAmount ?? ""
         maxAmount = filters.maxAmount ?? ""
        selectedDateOption = sortDateToStarterFilters()
        selectedAmountOption = sortAmountToStarterFilters()
        selectedMaterialTypes = filters.contentType
        selectedEnrollmentTypes = filters.enrollmentType
    }
    
    private func preprerSelectedFilters() {
        displayedFilters.minAmount = minAmount
        displayedFilters.maxAmount = maxAmount
        displayedFilters.sortDate = sortDateFromSelectedValues()
        displayedFilters.sortAmount = sortAmountFromSelectedValues()
        displayedFilters.contentType = selectedMaterialTypes
        displayedFilters.enrollmentType = selectedEnrollmentTypes
    }

    private func sortDateFromSelectedValues() -> TransactionFilterOptions.SortDate? {
        
        switch selectedDateOption {
        case .latest:
            return .dateLatest
        case .oldest:
            return .dateOldest
        case .none:
            return nil
        }
    } 
    private func sortAmountFromSelectedValues() -> TransactionFilterOptions.SortAmount? {
        
        switch selectedAmountOption {
        case .highest:
            return .amountHighest
        case .lowest:
            return .amountLowest
        case .none:
            return nil
        }
    }
    
    private func sortDateToStarterFilters() -> DateFilterOptions? {
        switch filters.sortDate {
        case .dateLatest:
            return .latest
        case.dateOldest :
            return .oldest
        case .none:
            return nil
        }
    }
    
    private func sortAmountToStarterFilters() -> AmountFilterOptions? {
        switch filters.sortAmount {
        case .amountLowest:
            return .lowest
        case .amountHighest:
            return .highest
        case .none:
            return nil
        }
    }
}
