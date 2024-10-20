//
//  BillDetailsView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import SwiftUI
import EMLECore

struct BillDetailsView: View {
let monitorBill: MonitorBill
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Text("Bill Details")
                .customStyle(.headline, .onSurface)
                .padding(.vertical)
            
            
            if let students = monitorBill.students {
                BillDetailsItemView(title: "Student", studentNumber:  students.value?.stringTwoDecimalDigit ?? "", hourCost: students.amount, total: students.total)
            }
            if let tokens = monitorBill.tokens {
                myDivider
                BillDetailsItemView(title: "Tokens", studentNumber: tokens.value?.stringTwoDecimalDigit ?? "", hourCost: tokens.amount, total: tokens.total)
            }
            
            if let bandwidth = monitorBill.bandwidth {
                myDivider
                BillDetailsItemView(title: "Bandwidth", studentNumber:  bandwidth.value?.stringTwoDecimalDigit ?? "", hourCost: bandwidth.amount, total: bandwidth.total)
            }
            
            if let storage = monitorBill.storage {
                myDivider
                BillDetailsItemView(title: "Storage", studentNumber:  storage.value?.stringTwoDecimalDigit ?? "", hourCost: storage.amount, total: storage.total)
            }
        }
        .customCornerRadius(12)
        .padding()
    }
    
    private var myDivider: some View{
        Divider()
            .foregroundStyle(.black)
    }
}
