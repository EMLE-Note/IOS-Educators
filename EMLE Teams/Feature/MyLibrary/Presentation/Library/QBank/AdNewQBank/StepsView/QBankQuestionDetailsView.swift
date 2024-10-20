//
//  QBankQuestionDetailsView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 12/09/2024.
//

import SwiftUI
import EMLECore

struct QBankQuestionsDetailView: View {
    @ObservedObject var viewModel: AddQBankViewModel

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.questions.isEmpty {
                Text("No questions added yet.").padding()
            } else {
                questionDetailsView(question: viewModel.questions[viewModel.currentIndex])
            }
            
            Spacer()
            StepButtons(viewModel: viewModel, previosAction: viewModel.goToPreviousQuestion, nextAction: viewModel.goToNextQuestion, isNextButtonDisabled: viewModel.currentIndex >= viewModel.questions.count - 1, isBackButtonDisabled: viewModel.currentIndex <= 0)
        }
    }
    
    @ViewBuilder
    private func questionDetailsView(question: QuestionBankQuestionModel) -> some View {
        VStack(alignment: .leading) {
            NoIndicatorsScrollView {
                questionView(question)
            }
        }
    }
    
    @ViewBuilder
    private func questionView(_ question: QuestionBankQuestionModel) -> some View {
        VStack(alignment: .leading) {
            Text(question.description)
                .customStyle(.bodySmall, .subtitle)
            
            Text(question.name)
                .customStyle(.headline, .onSurface)
            
            previousExamView(question)
            referencesSyllabiView(question)
            
            answersView(question)
        }
        .padding(.horizontal, .md)
    }
    
    @ViewBuilder
    private func previousExamView(_ question: QuestionBankQuestionModel) -> some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .trailing) {
                CustomTextField(title: LibraryStrings.previousExam.localized,
                                placeholder: LibraryStrings.addPreviousExam.localized,
                                value: .constant(viewModel.selectedReferencePreviousExams.displayName),
                                borderStateColor: viewModel.checkPreviousExam(question: question) ? .success : .error,
                                hasChevron: true,
                                disable: true)
                .onTapGesture {
                    viewModel.presentDialog(for: .referencePreviousExam)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            listPreviousExam(question)
        }
        .padding(.vertical, .md)
    }
    
    @ViewBuilder
    private func referencesSyllabiView(_ question: QuestionBankQuestionModel) -> some View {
        VStack(alignment: .leading) {
            CustomTextField(title: LibraryStrings.referencesSyllabi.localized,
                            placeholder: LibraryStrings.selectSyllabi.localized,
                            value: .constant(question.reference_syllabus?.displayName ?? ""),
                            borderStateColor: viewModel.checkReferenceSyllabus(question: question) ? .success : .error,
                            hasChevron: true,
                            disable: true)
            .onTapGesture {
                viewModel.presentDialog(for: .referencesSyllabus)
            }
        }
        .padding(.vertical, .md)
    }
    
    @ViewBuilder
    private func answersView(_ question: QuestionBankQuestionModel) -> some View {
        VStack(alignment: .leading) {
            Text(LibraryStrings.answers.localized)
                .customStyle(.headline, .onSurface)
            
            AnswersListView(answers: question.answers, selectAction: viewModel.onAnswerSelect)
        }
    }
    
    @ViewBuilder
    private func listPreviousExam(_ question: QuestionBankQuestionModel) -> some View {
        VStack {
            ForEach(question.previous_exam_id, id: \.self) { previousExamId in
                if let exam = viewModel.referencePreviousExams.first(where: { $0.examId == previousExamId }) {
                    HStack {
                        Text(exam.name)
                            .customStyle(.bodySmall, .onSurface)
                        
                        Spacer()
                        
                        Image.deletePermanently
                            .frame(width: 24, height: 24)
                            .foregroundColor(.red)
                            .onTapGesture {
                                viewModel.removePreviousExam(withId: previousExamId)
                            }
                    }
                    .padding(.xxSm)
                }
            }
        }
    }
}

