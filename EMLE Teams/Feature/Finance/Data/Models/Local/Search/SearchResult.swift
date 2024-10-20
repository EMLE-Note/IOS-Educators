//
//  SearchResult.swift
//  EMLE Teams
//
//  Created by iOSAYed on 15/08/2024.
//

import Foundation

struct SearchResult<T>: Identifiable {
    
    let id: UUID = UUID()
    let content: T
}

extension SearchResult<ExternalWallet> {
    
    static let empty: SearchResult<ExternalWallet> = {
        SearchResult<ExternalWallet>(content: .placeholder)
    }()
    
    static let placeholder: SearchResult<ExternalWallet> = {
        SearchResult<ExternalWallet>(content: .placeholder)
    }()
}

extension [SearchResult<ExternalWallet>] {
    
    static let placeholder: [SearchResult<ExternalWallet>] = {
        var placeholder: [SearchResult<ExternalWallet>] = []
        
        for i in 0..<10 {
            placeholder.append(SearchResult<ExternalWallet>(content: .placeholder))
        }
        
        return placeholder
    }()
}

extension SearchResult<Enrollment> {
    
    static let empty: SearchResult<Enrollment> = {
        SearchResult<Enrollment>(content: .placeholder)
    }()
    
    static let placeholder: SearchResult<Enrollment> = {
        SearchResult<Enrollment>(content: .placeholder)
    }()
}

extension [SearchResult<Enrollment>] {
    
    static let placeholder: [SearchResult<Enrollment>] = {
        var placeholder: [SearchResult<Enrollment>] = []
        
        for i in 0..<10 {
            placeholder.append(SearchResult<Enrollment>(content: .placeholder))
        }
        
        return placeholder
    }()
}

//extension SearchResult<Quiz> {
//    
//    static let empty: SearchResult<Quiz> = {
//        SearchResult<Quiz>(title: "",
//                           content: .placeholder)
//    }()
//    
//    static let placeholder: SearchResult<Quiz> = {
//        SearchResult<Quiz>(title: "Search",
//                           content: .placeholder)
//    }()
//}
//
//extension [SearchResult<Quiz>] {
//    
//    static let placeholder: [SearchResult<Quiz>] = {
//        var placeholder: [SearchResult<Quiz>] = []
//        
//        for i in 0..<10 {
//            placeholder.append(SearchResult<Quiz>(title: "Search result",
//                                                  content: .placeholder))
//        }
//        
//        return placeholder
//    }()
//}
