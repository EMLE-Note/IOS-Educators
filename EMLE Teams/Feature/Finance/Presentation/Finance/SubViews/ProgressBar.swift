//
//  ProgressBar.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import SwiftUI
import EMLECore

struct ProgressBar: View {
    let progress: Double
    let totalBalance: Double = 5000
    let balanceUsed: Double
    let currancy: String
    
    var progressBarColor: Color {
        if totalBalance == balanceUsed || balanceUsed >= (totalBalance * 0.7) {
            return .red
        } else {
            return .secondaryColor
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 21)
                .foregroundColor(Color.white)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: CGFloat(progress) * UIScreen.main.bounds.width * 0.84, height: 21)
                .foregroundColor(progressBarColor)
        }
        .overlay(alignment: .center) {
            Text("\(balanceUsed, specifier: "%.0f") / \(totalBalance, specifier: "%.0f") \(currancy)")
                .customStyle(.caption1, .onSecondary)
        }
    }
}

#Preview {
    ProgressBar(progress: 0.9, balanceUsed: 5000, currancy: "EGP")
}
