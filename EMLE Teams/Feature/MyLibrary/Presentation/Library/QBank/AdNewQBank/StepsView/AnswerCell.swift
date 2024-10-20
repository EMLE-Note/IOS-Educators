//
//  AnswerCell.swift
//  EMLE Learners
//
//  Created by Mustafa Merza on 5/9/24.
//

import SwiftUI
import EMLECore

struct AnswerCell: View {
    
    var answer: Answer
    
    var body: some View {
        answerItem
    }
    
    private var answerItem: some View  {
        HStack(spacing: 16) {
            
            state
            
            answerText
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, defaultHPadding)
        .padding(.vertical, 12)
        .withCardBorder(backgroundColor: .container,
                        cornerRadius: 12,
                        borderColor: borderColor)
    }
    
    @ViewBuilder
    private var state: some View {
        
        switch answer.state {
        case .idle:
            idleState
        case .selected:
            selectedState
        case .correct:
            correctState
        case .wrong:
            wrongState
        }
    }
    
    private var answerText: some View {
        Text(answerString)
            .customStyle(.bodySmall, .onSurface)
    }
    
    private var answerString: String {
        "".appendingFormat("%@) %@",
                           answer.number,
                           answer.name)
    }
    
    private var idleState: some View {
        Circle()
            .customStroke(.neutral)
            .frame(width: 18, height: 18)
    }
    
    private var selectedState: some View {
        Circle()
            .customFill(.primary)
            .frame(width: 18, height: 18)
    }
    
    private var correctState: some View {
        Circle()
            .customFill(.success)
            .frame(width: 18, height: 18)
            .overlay {
                
                Image.successIc
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .customForeground(.onSurface)
            }
    }
    
    private var wrongState: some View {
        Circle()
            .customFill(.error)
            .frame(width: 18, height: 18)
            .overlay {
                
                Image.x
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .customForeground(.onSurface)
            }
    }
    
    private var borderColor: ColorStyle {
        
        switch answer.state {
        case .idle:
                .clear
        case .selected:
                .clear
        case .correct:
                .success
        case .wrong:
                .error
        }
    }
}

#Preview {
    AnswerCell(answer: .placeholder)
}
