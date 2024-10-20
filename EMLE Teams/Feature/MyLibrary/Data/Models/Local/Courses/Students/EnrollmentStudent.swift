//
//  Enrollment.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 19/08/2024.
//

import Foundation

// MARK: - Enrollment
struct EnrollmentStudent: Hashable, Identifiable {
    let id = UUID()
    let enrollmentId: Int
    let security: Security
    let status: Int
    let expireAt: String?
    let student: Student
    let location: String?
    let createdAt: String?
    
    static func == (lhs: EnrollmentStudent, rhs: EnrollmentStudent) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension EnrollmentStudent {
    static let placeholder = EnrollmentStudent(enrollmentId: 0, security: .placeholder, status: 0, expireAt: "", student: .placeholder, location: "", createdAt: "")
}

extension [EnrollmentStudent] {
    static let placeholder: [EnrollmentStudent] = {
        var placeholder: [EnrollmentStudent] = []
        
        for i in 0..<5 {
            placeholder.append(EnrollmentStudent(enrollmentId: 0, security: .placeholder, status: 0, expireAt: "", student: .placeholder, location: "", createdAt: ""))
        }
        
        return placeholder
    }()
}
