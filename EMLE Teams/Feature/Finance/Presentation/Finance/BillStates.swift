//
//  BillStates.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import SwiftUI
import EMLECore

enum BillStates: Int {
    case active  = 1
    case pastDue = 2
    case overDue = 3
}

extension BillStates {
    
    var title: String {
        switch self {
        case .active:
            return  "Active"
        case .pastDue:
            return "Past due"
        case .overDue:
            return "Overdue"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .active:
            return .primaryColor
        case .pastDue:
            return .yellow
        case .overDue:
            return .red
        }
    }
    
    var gradiantBackground: [Gradient.Stop] {
        switch self {
        case .active:
            return  [
                Gradient.Stop(color: Color(red: 0, green: 0.71, blue: 0.86), location: 0.00),
                Gradient.Stop(color: Color(red: 0, green: 0.61, blue: 0.77), location: 0.50),
                Gradient.Stop(color: Color(red: 0, green: 0.51, blue: 0.69), location: 1.00),
                ]
        case .pastDue:
            return [
                Gradient.Stop(color: Color(red: 0.98, green: 0.75, blue: 0.14), location: 0.00),
                Gradient.Stop(color: Color(red: 0.96, green: 0.62, blue: 0.04), location: 1.00),
                ]
        case .overDue:
            return [
                Gradient.Stop(color: Color(red: 0.73, green: 0.11, blue: 0.11), location: 0.00),
                Gradient.Stop(color: Color(red: 0.78, green: 0.24, blue: 0.28).opacity(0.98), location: 1.00),
                ]
        }
    }
    
   
    
}
