//
//  AnswersListView.swift
//  EMLE Learners
//
//  Created by Mustafa Merza on 5/9/24.
//

import SwiftUI

struct AnswersListView: View {
    
    var answers: [Answer]
    
    var selectAction: AnswerDelegate = nil
    
    var body: some View {
        list
    }
    
    private var list: some View {
        VStack(spacing: 16) {
            
            ForEach(answers) { answer in
                
                AnswerCell(answer: answer)
                    .onTapGesture {
                        selectAction?(answer)
                    }
            }
        }
    }
}

#Preview {
    AnswersListView(answers: .placeholder)
}
