//
//  BillCardView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 29/06/2024.
//

import SwiftUI
import EMLECore

struct BillCardView: View {
    let state:BillStates
    let backgroundColors: [Gradient.Stop]
    let progressRate:Double
    let balanceUsed:Double
    let currantBill: Bill
    let total:String
    let onClickedOnPayNow: EmptyAction
    
    var borderColor: Color {
        switch state {
        case .active:
            return  .clear
        case .pastDue:
            return .black
        case .overDue:
            return .white
        }
    }
    
    var textColor: ColorStyle {
        switch state {
        case .active,.overDue:
            return .onPrimary
        case .pastDue:
            return .onSecondary
        }
    }
   
    var body: some View {
        VStack(spacing: 25) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Total Bill")
                        .customStyle(.bodySmall, textColor)
                    
                    Text("\(total) \(currantBill.currency?.code ?? "")")
                        .customStyle(.buttonText, textColor)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Due date")
                        .customStyle(.bodySmall, textColor)
                    
                    Text(currantBill.billDueDate)
                        .customStyle(.buttonText, textColor)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Bill State")
                        .customStyle(.bodySmall, textColor)
                    
                    Text(state.title)
                        .customStyle(.buttonText, textColor)
                }
            }

            VStack(alignment:.leading) {
                Text("Bill Capacity")
                    .customStyle(.subheadline, textColor)
                
                ProgressBar(progress: progressRate, balanceUsed: balanceUsed, currancy: currantBill.currency?.code ?? "")
            }
            
            HStack{
                
                Spacer()
                
                Group {
                    
                    switch state {
                    case .active:
                        
                        PrimaryButton(title: buttonText,
                                      action: onClickedOnPayNow,
                                      trailingIcon: buttonIcon)
                        
                    case .pastDue, .overDue:
                        
                        OutlinedButton(title: buttonText,
                                       action: onClickedOnPayNow,
                                       trailingIcon: buttonIcon,
                                       textColor: state == .pastDue ? .onSecondary : .onPrimary,
                                       borderColor: state == .pastDue ? .onSecondary : .onPrimary)
                    }
                }
                .frame(width: 145)
            }
        }
        .padding()
        .background(
            LinearGradient(
                stops:backgroundColors,
                startPoint: UnitPoint(x: 0, y: 0),
                endPoint: UnitPoint(x: 1, y: 0)
            )
        )
        .customCornerRadius(10)
    }
    
    private var buttonText: String {
        "Pay Now"
    }
    
    private var buttonIcon: Image {
        Image(systemName: "arrow.forward")
    }
}

#Preview {
    BillCardView(state: .active, backgroundColors: [], progressRate: 1, balanceUsed: 5000, currantBill: .placeholder, total: "5000", onClickedOnPayNow: {})
}
