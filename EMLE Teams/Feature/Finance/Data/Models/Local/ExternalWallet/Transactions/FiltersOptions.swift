//
//  FiltersOptions.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/07/2024.
//

import Foundation

struct TransactionFilterOptions {
    var enrollmentType: Set<EnrollmentTypeFilterOptions>
    var contentType: Set<MaterialTypeFilterOptions>
    var maxAmount: String?
    var minAmount: String?
    var teamStaffID: String?
    var searchQuery: String?
    var sortDate: SortDate?
    var sortAmount: SortAmount?
    
    enum SortDate {
        case dateLatest
        case dateOldest
    } 
    enum SortAmount {
        case amountLowest
        case amountHighest
    }
    
    var isSelected: Bool {
           return !enrollmentType.isEmpty ||
                  !contentType.isEmpty ||
                   (minAmount != nil || minAmount == "" ) ||
                   (maxAmount != nil || maxAmount == "" ) ||
                    sortDate != nil  || sortAmount != nil
       }
}

extension TransactionFilterOptions {
    static let placeholder: TransactionFilterOptions = {
        TransactionFilterOptions(enrollmentType:[], contentType: [],maxAmount: nil,minAmount: nil,sortDate: nil,sortAmount: nil)
    }()
    
    static let empty: TransactionFilterOptions = {
        TransactionFilterOptions(enrollmentType:[], contentType: [],maxAmount: nil,minAmount: nil,sortDate: nil,sortAmount: nil)
    }()
}
