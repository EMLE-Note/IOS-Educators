//
//  CustomBarProgressView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 20/06/2024.
//

import SwiftUI
import EMLECore

struct CustomBarProgressView: View {
    var steps: Int
    var currentStep: Int
    var isSeperated:Bool = false
    
    var body: some View {
        HStack(spacing: isSeperated ? 4 : -4) {
            ForEach(0..<steps, id: \.self) { step in
                Rectangle()
                    .fill(step <= currentStep ? Color.primaryColor : Color.gray)
                    .customCornerRadius(3)
                    .frame(maxWidth: .infinity,maxHeight: 4)
            }
            
        }
        .padding()
    }
}


#Preview {
    CustomBarProgressView(steps: 4, currentStep: 1)
}
