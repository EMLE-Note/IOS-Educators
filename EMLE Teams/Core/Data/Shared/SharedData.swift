//
//  SharedData.swift
//  EMLE Teams
//
//  Created by iOSAYed on 03/07/2024.
//

import Foundation

class SharedData {
    static let shared = SharedData()
    
    @Published var currancy: Currency = .placeholder
    
}
