//
//  BillDetailItemView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import SwiftUI
import EMLECore

struct BillMonitorItemView: View {
    var title: String
    var count: String?
    var amount: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .customStyle(.bodyMedium, .subtitle)
            
            if let count = count {
                Text("\(count) Hr")
                    .customStyle(.headline, .onSurface)
                
            }else {
                Spacer()
            }
            HStack {
                Spacer()
                if let amount = amount {
                    Text("\(amount)")
                        .customStyle(.subheadline, .primary)
                }
            }
            .padding(.top)
               
        }
        .frame(maxWidth: .infinity)
        .padding()
        .customBackground(.container)
        .customCornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 15, x: 0, y: 15)

    }
}

#Preview {
    BillMonitorItemView(title: "Students",count: "1220", amount: "2500 EGP")
}
