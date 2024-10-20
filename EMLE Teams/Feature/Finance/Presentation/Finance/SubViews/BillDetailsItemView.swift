//
//  BillDetailsItemView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import SwiftUI
import EMLECore

struct BillDetailsItemView: View {
    let title: String
    let studentNumber:String
    let hourCost: String
    let total: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .customStyle(.headline, .primary)
            
            HStack {
                detailsItem(title: "Number", value: "\(studentNumber)")
                Spacer()
                detailsItem(title: "Price/Student", value: hourCost)
                Spacer()
                detailsItem(title: "Total", value: total)
            }
        }
        .padding(8)
        .customBackground(.container)
        
        .shadow(color: Color(red: 0.63, green: 0.84, blue: 1).opacity(0.05), radius: 10, x: 0, y: -10)

    }
    
    private func detailsItem(title:String , value:String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .customStyle(.bodySmall, .subtitle)
            
            Text(value)
                .customStyle(.headline, .onSurface)
        }
    }
}

#Preview {
    BillDetailsItemView(title: "Student", studentNumber: "200", hourCost: "15 EGP", total: "3000 EGP")
}
