//
//  BillSummaryView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import SwiftUI
import EMLECore

struct BillSummaryView: View {
    let message: String
    let state: BillStates
    let backgroundColors: [Gradient.Stop]
    let progressRate: Double
    let balanceUsed: Double
    let total:String
    let currantBill: Bill
    let onClickedOnBillCard: EmptyAction
    let onClickedOnPayNow: EmptyAction
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("My Bill")
                .customStyle(.headline, .onSurface)
            
            Text(message)
                .lineLimit(3)
                .customStyle(.bodySmall, .subtitle)

            BillCardView(state: state, backgroundColors: backgroundColors, progressRate: progressRate, balanceUsed: balanceUsed, currantBill: currantBill, total:total, onClickedOnPayNow: onClickedOnPayNow)
                .onTapGesture {
                    onClickedOnBillCard?()
                }
        }
    }
}

#Preview {
    BillSummaryView(message: "Your bill capacity limit is currently at its default state and it will be automatically increase based on your consumption and payment history.", state: .active, backgroundColors: [
        Gradient.Stop(color: Color(red: 0, green: 0.71, blue: 0.86), location: 0.00),
        Gradient.Stop(color: Color(red: 0, green: 0.61, blue: 0.77), location: 0.50),
        Gradient.Stop(color: Color(red: 0, green: 0.51, blue: 0.69), location: 1.00)], progressRate: 0.5, balanceUsed: 2000, total: "3000", currantBill: .placeholder, onClickedOnBillCard: {}, onClickedOnPayNow: {})
}
