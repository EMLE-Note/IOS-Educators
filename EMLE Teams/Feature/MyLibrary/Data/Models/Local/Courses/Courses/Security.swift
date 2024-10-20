//
//  Security.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation

struct Security: Hashable, Identifiable {
    let id = UUID()
    
    let fingerPrintTime: Int?
    let studentNameTime: Int?
    let preventScreenRecord: Bool?
    let notificationSecurity: Bool?
    let headphoneSecurity: Bool?
    let nationalIdSecurity: Bool?
    let faceRecognitionSecurity: Bool?
    
    let signature: Signature?
}

extension Security: Equatable {
    static func == (lhs: Security, rhs: Security) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Security {
    
    static let placeholder: Security = {
        Security(fingerPrintTime: 600,
                 studentNameTime: 600,
                 preventScreenRecord: true,
                 notificationSecurity: false,
                 headphoneSecurity: false,
                 nationalIdSecurity: false,
                 faceRecognitionSecurity: false,
                 signature: .placeholder)
    }()
    
    static let defaultSecurity: Security = {
        Security(fingerPrintTime: 0,
                 studentNameTime: 0,
                 preventScreenRecord: true,
                 notificationSecurity: false,
                 headphoneSecurity: false,
                 nationalIdSecurity: false,
                 faceRecognitionSecurity: false,
                 signature: nil)
    }()
}
