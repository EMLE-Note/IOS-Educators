//
//  Activations.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/10/2024.
//

import Foundation

struct Activations: Hashable, Identifiable {
    let id = UUID()
    let activationID: Int
    let type: String
    let registrationID: Int
    let registrationName: String
    let paidAmount: Int
    let student: Student
    let requestable: Requestable
    let createdAt: String
    
    static func == (lhs: Activations, rhs: Activations) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Activations {
    
    static let placeholder: Activations = {
        Activations(
            activationID: 0,
            type: "",
            registrationID: 0,
            registrationName: "",
            paidAmount: 0,
            student: .placeholder,
            requestable: .placeholder,
            createdAt: ""
        )
    }()
}

extension [Activations] {
    
    static let placeholder: [Activations] = {
        var placeholder: [Activations] = []
        
        for i in 0..<5 {
            placeholder.append(Activations(
                activationID: 0,
                type: "",
                registrationID: 0,
                registrationName: "",
                paidAmount: 0,
                student: .placeholder,
                requestable: .placeholder,
                createdAt: ""
            )
            )}
        
        return placeholder
    }()
    
    static let libraryPlaceholder: [Activations] = {
        var placeholder: [Activations] = []
        
        for i in 0..<10 {
            
            var course = Activations(
                activationID: 0,
                type: "",
                registrationID: 0,
                registrationName: "",
                paidAmount: 0,
                student: .placeholder,
                requestable: .placeholder,
                createdAt: ""
            )
            
            
            placeholder.append(course)
        }
        
        return placeholder
    }()
}
