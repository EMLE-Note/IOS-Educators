//
//  QBankQuestionsView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct QBankQuestionsView: View {
    @ObservedObject var viewModel: AddQBankViewModel

    var body: some View {
        VStack(alignment: .leading) {
            StepHeaderView(title: viewModel.addQBankSteps.headerTitle, subTitle: viewModel.addQBankSteps.headerSubtitle)
            
            NoIndicatorsScrollView {
                ForEach(Array(viewModel.questions.enumerated()), id: \.element.id) { index, question in
                    questions(with: question, index: index + 1)
                }
            }
            
            Spacer()
            PrimaryButton(title: LibraryStrings.finishAndPublish.localized, action: {
                viewModel.onFinishAndPublishTapped()
            })
            .clipShape(Capsule())
            .disabled(!allQuestionsValidated)
            .padding()
        }
    }
    
    private func questions(with question: QuestionBankQuestionModel, index: Int) -> some View {
        VStack(alignment: .leading) {
            Text("\(index). \(question.name)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .customBackground(.onPrimary)
        .withCardShadow(backgroundColor: .onSurface, cornerRadius: .sm)
        .withCardBorder(borderColor: borderColorFor(question: question))
        .padding(.horizontal, .xSm)
        .onTapGesture {
            print("\(index). \(question.name)")
            viewModel.showQuestionDetails(questionIndex: index - 1)
        }
    }

    private func borderColorFor(question: QuestionBankQuestionModel) -> ColorStyle {
        return (viewModel.checkReferenceSyllabus(question: question) && viewModel.checkPreviousExam(question: question)) ? .success : .error
    }

    private var allQuestionsValidated: Bool {
        viewModel.questions.allSatisfy { question in
            viewModel.checkReferenceSyllabus(question: question) && viewModel.checkPreviousExam(question: question)
        }
    }
}
