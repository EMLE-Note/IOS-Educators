//
//  InstructorOptions.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation

enum InstructorOptions: Int,CaseIterable{
    case instructor = 0
    case notInstractor = 1
    
    var title: String {
           switch self {
           case .instructor:
               return "Instructor"
           case .notInstractor:
               return "Not Instructor"
           }
       }
}
