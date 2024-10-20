//
//  Student.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/07/2024.
//

import EMLECore
import Foundation

struct Student: Codable {
    let id: Int
    let name, mobile: String
    let image: ImageUrl?
}

extension Student {
    static let placeholder = Student(id: 0, name: "student Name", mobile: "+201112223402", image: nil)
}
