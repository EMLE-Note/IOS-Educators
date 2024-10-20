//
//  AddQBankView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/09/2024.
//

import SwiftUI
import EMLECore

struct AddQBankView: View {
    @StateObject var viewModel: AddQBankViewModel
    
    init(coordinator: AddQBankViewCoordinating) {
        _viewModel = StateObject(wrappedValue: AddQBankViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        MainView(viewModel: viewModel) {
            navigationBar
            if !(viewModel.addQBankSteps == .seventh || viewModel.addQBankSteps == .questions) {
                progressView
            }
            
            currentStepView
            
            if !(viewModel.addQBankSteps == .sixth ||  viewModel.addQBankSteps == .seventh || viewModel.addQBankSteps == .questions) {
                StepNavigationButtons(viewModel: viewModel, backAction: viewModel.nextButtonAction(), nextAction: viewModel.nextAction, isNextButtonDisabled: viewModel.addQBankSteps.nextButtonDisabled(viewModel: viewModel))
            }
            Spacer()
        }
        .sheet(isPresented: $viewModel.imagePickerPresenting) {
            ImagePicker(pickerImage: $viewModel.qbankImage, sourceType: viewModel.sourceType)
        }
        .sheet(isPresented: $viewModel.isShowingPicker) {
            DocumentPicker { url in viewModel.loadExcelFile(at: url) }
        }
        .customSheet(isPresented: $viewModel.isPresentCustomSheetView, height: 300, detents: [.medium, .large]) {
            VStack {
                Spacer()
                if let option = viewModel.currentOption {
                    switch option {
                    case .certificate:
                        certificatesView
                    case .reference:
                        referenceView
                    case .referencePreviousExam:
                        referencePreviousExamsView
                    case .referencesSyllabus:
                        referencesSyllabusView
                    }
                }
                Spacer()
            }
            .background(Color.white)
        }
        .customSheet(isPresented: $viewModel.isShowDurationDate,
                     height: 200,
                     detents: [.medium, .large]) {
            VStack {
                CustomPickerItems(
                    singleSelectedItem: $viewModel.selectedDurationDate,
                    items: viewModel.durationDateType,
                    selectedColor: .neutral,
                    areItemsEqual: { $0 == $1 }
                ) {  viewModel.selectDurationType(viewModel.selectedDurationDate) }
                    .padding()
            }
        }
    }
    
    @ViewBuilder
    private var currentStepView: some View {
        switch viewModel.addQBankSteps {
        case .first:
            QBankFirstStepView(viewModel: viewModel)
        case .second:
            QBankSecondStepView(viewModel: viewModel)
        case .third:
            QBankThirdStepView(viewModel: viewModel)
        case .fourth:
            QBankFourthStepView(viewModel: viewModel)
        case .fifth:
            QBankFifthStepView(viewModel: viewModel)
        case .sixth:
            QBankSixthStepView(viewModel: viewModel)
        case .seventh:
            QBankQuestionsView(viewModel: viewModel)
        case .questions:
            QBankQuestionsDetailView(viewModel: viewModel)
        }
    }
}

// Preview for SwiftUI View
struct AddQBankView_Previews: PreviewProvider {
    static var previews: some View {
        AddQBankView(coordinator: AddQBankViewCoordinator(navigationController: UINavigationController(), tabBarController: MainTabBarController()))
    }
}

extension AddQBankView {
    private var progressView: some View {
        HStack {
            CustomBarProgressView(steps: 7, currentStep: viewModel.addQBankSteps.rawValue)
        }
    }
}

// MARK: - Navigation View -

extension AddQBankView {
    private var navigationBar: some View {
        HStack {
            CustomNavigationBar.Checkout(title: LibraryStrings.addNewQBank.localized,
                                         backAction: viewModel.nextButtonAction())
                .padding(.bottom, .xxSm)
                .customBackground(.container)
                .padding(.horizontal, defaultHPadding)
            
            Spacer()
            
            if viewModel.addQBankSteps == .questions {
                PrimaryButton(title: LibraryStrings.question.localized) {
                    viewModel.onQuestionTapped()
                }
                .clipShape(Capsule())
                .frame(width: 130, height: 32)
                .padding(.horizontal, .xSm)
                .padding(.vertical, .xSm)
            }
        }
        .customBackground(.container)
        .padding(.bottom, .md)
    }
    
    func getSheetView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        VStack {
            Spacer()
            
            VStack(spacing: .xSm) {
                content()
            }
            .padding(.horizontal, defaultHPadding)
            .padding(.top, .sm)
            .padding(.bottom, .xxxBig)
            .customBackground(.container)
            .customCornerRadii(.sm, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea()
    }
}

// MARK: - Certificates -

extension AddQBankView {
    private var certificatesView: some View {
        getSheetView {
            NoIndicatorsScrollView {
                TreeItemsView(items: viewModel.certificates,
                              selectedItem: viewModel.selectedCertificate,
                              selectAction: viewModel.onCertificatesSelect)
            }
            .frame(maxHeight: 200)
        }
        
    }
}

// MARK: - Reference -

extension AddQBankView {
    private var referenceView: some View {
        getSheetView {
            NoIndicatorsScrollView {
                TreeItemsView(items: viewModel.references,
                              selectedItem: viewModel.selectedReference,
                              selectAction: viewModel.onReferencesSelect)
            }
            .frame(maxHeight: 200)
        }
        
    }
}

// MARK: - ReferencePreviousExams -

extension AddQBankView {
    private var referencePreviousExamsView: some View {
        getSheetView {
            NoIndicatorsScrollView {
                TreeItemsView(items: viewModel.referencePreviousExams,
                              selectedItem: viewModel.selectedReferencePreviousExams,
                              selectAction: viewModel.onReferencePreviousExamSelect)
            }
            .frame(maxHeight: 200)
        }
        
    }
}

// MARK: - ReferencesSyllabus -

extension AddQBankView {
    private var referencesSyllabusView: some View {
        getSheetView {
            NoIndicatorsScrollView {
                TreeItemsView(parentItem: viewModel.parentReferencesSyllabus[viewModel.currentIndex],
                              backAction: viewModel.onReferenceSyllabussBackClick,
                              items: viewModel.displayedreferencesSyllabus[viewModel.currentIndex],
                              selectedItem: viewModel.questions[viewModel.currentIndex].reference_syllabus,
                              selectAction: viewModel.onReferenceSyllabusSelect,
                              doneAction: viewModel.onReferenceSyllabusDoneClick)
            }
            .frame(maxHeight: 200)
        }
    }
}


