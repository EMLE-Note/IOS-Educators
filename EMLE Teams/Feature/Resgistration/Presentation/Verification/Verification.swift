//
//  Verification.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 15/04/2024.
//

import SwiftUI
import EMLECore

struct Verification: View {
    enum FocusField: Hashable {
        case field
    }
    
    @Binding var code: String
    
    @FocusState var focusedField: FocusField?
    
    var body: some View {
        ZStack {
            
            TextField("", text: $code)
                .customFont(size: 18, weight: ._500, lineHeight: 20)
                .customForeground(.clear)
                .frame(width:1, height: 1)
                .padding(.vertical, 30)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($focusedField, equals: .field)
                .blendMode(.screen)
                .opacity(0.001)
            
            codeItems
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    focusedField = .field
                }
        }
    }
    
    private var codeItems: some View {
        HStack(spacing: 0) {
            getCodeItem(for: 0)
            ForEach(1..<6) { index in
                Spacer()
                getCodeItem(for: index)
            }
        }
        .environment(\.layoutDirection, .leftToRight)
    }
    
    @ViewBuilder
    private func getCodeItem(for index: Int) -> some View {
        let isSelected = focusedField == .field && code.count == index
        
        if index < code.count {
            ValidationItem(value: code[index], isSelected: isSelected)
        }
        else {
            ValidationItem(value: "", isSelected: isSelected)
        }
    }
}

#Preview {
    VerificationTest()
}

struct VerificationTest: View {
    
    @State var code: String = "123456"
    
    var body: some View {
        Verification(code: $code)
    }
}
