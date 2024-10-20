//
//  EnrollmentReceivable.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import EMLECore
import Foundation

struct Secretary: Codable, Identifiable,Hashable {
    let id: UUID = UUID()
    
    let SecretaryId: Int
    let name: String
    let status, isInstructor: Int
    let role: String
    let image: ImageUrl?
    let balance: Double
    
    
    static func == (lhs: Secretary, rhs: Secretary) -> Bool {
       return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
extension Secretary {
    static let placeholder = Secretary(SecretaryId: 0, name: "Elsayed Ahmed", status: 0, isInstructor: 0, role: "Doctor", image:ImageUrl(urlString: "https://dev.emleplayer.com/tenancy/assets/media/users/7/17171002182715225.jpg"), balance: 0)
}
