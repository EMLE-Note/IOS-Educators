//
//  EnrollmentFilterOptions.swift
//  EMLE Teams
//
//  Created by iOSAYed on 11/08/2024.
//

import Foundation

struct EnrollmentFilterOptions {
    var enrollmentType: Set<EnrollmentTypeFilterOptions>
    var contentType: Set<MaterialTypeFilterOptions>
    var maxAmount: String?
    var minAmount: String?
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

extension EnrollmentFilterOptions {
    static let placeholder: EnrollmentFilterOptions = {
        EnrollmentFilterOptions(enrollmentType:[], contentType: [],maxAmount: nil,minAmount: nil,sortDate: nil,sortAmount: nil)
    }()
    
    static let empty: EnrollmentFilterOptions = {
        EnrollmentFilterOptions(enrollmentType:[], contentType: [],maxAmount: nil,minAmount: nil,sortDate: nil,sortAmount: nil)
    }()
}
