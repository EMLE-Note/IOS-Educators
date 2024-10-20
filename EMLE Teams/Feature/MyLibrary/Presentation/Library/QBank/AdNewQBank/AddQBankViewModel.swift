//
//  AddQBankViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 07/09/2024.
//

import Foundation
import EMLECore
import SwiftUI
import Combine

typealias AnswerDelegate = GenericAction<Answer>

class AddQBankViewModel: MainViewModel {
    // MARK: - Dependencies
    let coordinator: AddQBankViewCoordinating

    // MARK: - Initializer
    init(coordinator: AddQBankViewCoordinating) {
        self.coordinator = coordinator
    }

    // MARK: - Inputs
    @Published var isShowingPicker = false
    @Published var validationMessages: [String] = []
    @Published var questions: [QuestionBankQuestionModel] = []
    @Published var questionDetails: QuestionBankQuestionModel = .placeHolder
    @Published var selectedAnswer: Answer?
    @Published var addQBankSteps: AddQBankSteps = .first
    @Published var imagePickerPresenting = false
    @Published var isShowExpirationDate: Bool = false
    @Published var isShowDurationDate: Bool = false
    @Published var isEnableTrial: Bool = false
    @Published var isShowPrice: Bool = true
    @Published var isShowStudentCount: Bool = true
    @Published var qbankId = ""
    @Published var qbankTitle = ""
    @Published var qbankPrice = ""
    @Published var qbankOverview = ""
    @Published var certificate = ""
    @Published var referenceId = -1
    @Published var durationDate = ""
    @Published var durationType = ""
    @Published var durationTrial = ""
    @Published var previousExam = ""
    @Published var referencesSyllabi = ""
    
    @Published var selectedDurationDate: DurationDateType = .days
    @Published var durationDateType: [DurationDateType] = DurationDateType.allCases
    @Published var fileName: String = LibraryStrings.uploadExcelFile.localized
    
    @Published var currentIndex: Int = 0 {
        didSet {
            prepareQuestionsNumbers()
        }
    }
    
    @Published var qbankImage: ImagePickerImage = .empty {
        didSet {
            didSelectImage = true
        }
    }
    
    @Published var qbankLoadingState: LoadingState = .loaded
    
    @Published var currentOption: QBankType?
    @Published var isPresentCustomSheetView: Bool = false
    
    @Published var certificates: [Certificate] = []
    @Published var selectedCertificate: Certificate = .emptyPlaceholder
    
    @Published var referencePreviousExams: [ReferencePreviousExam] = []
    @Published var selectedReferencePreviousExams: ReferencePreviousExam = .emptyPlaceholder
    
    @Published var references: [Reference] = []
    @Published var selectedReference: Reference = .emptyPlaceholder
    
    @Published var flatReferencesSyllabus: [ReferenceSyllabus] = []
    @Published var referencesSyllabus: [ReferenceSyllabus] = []
    @Published var displayedreferencesSyllabus: [[ReferenceSyllabus]] = [[]]
    @Published var parentReferencesSyllabus: [ReferenceSyllabus?] = []

    // MARK: - Outputs
    var isTabBarVisible: Bool { false }
    var cancellables = Set<AnyCancellable>()
    var sourceType: ImagePickerSourceType = .photos
    var didSelectImage = false
    var excelReader = ExcelReader()

    // MARK: - Computed Properties
    var isNextButtonEnabledFirst: Bool {
        !qbankId.isEmpty && !qbankTitle.isEmpty && !qbankPrice.isEmpty && !qbankOverview.isEmpty
    }
    
    var isNextButtonEnabledSecond: Bool {
        !selectedCertificate.name.isEmpty &&
        !selectedReference.name.isEmpty
    }
    
    private let answersIndexes = LibraryStrings.abcde.localized
    
    @Inject var getCertificatesUseCase: GetCertificatesUseCase
    @Inject var getReferencePreviousExamsUseCase: GetReferencePreviousExamsUseCase
    @Inject var getReferencesUseCase: GetReferencesUseCase
    @Inject var getReferenceSyllabiUseCase: GetReferenceSyllabiUseCase
    @Inject var createQBankUseCase: CreateQBankUseCase
}

extension AddQBankViewModel {
    func onAppear() {
        getCertificates()
    }
    
    func showQuestionDetails(questionIndex: Int) {
        addQBankSteps = .questions
        self.currentIndex = questionIndex
    }
    
    func goToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        }
    }
    
    func goToPreviousQuestion() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
    
    func onSelectedPreviousTapped() {
        
    }
    
    func onSelectedReferencesTapped() {
        
    }
    
    func selectAnswer(_ answer: Answer) {
        selectedAnswer = answer
    }
    
    func onAnswerSelect(answer: Answer) {
        print("onAnswerSelect")
        
        clearSelectedAnswer()
        
        if let index = questionDetails.answers.firstIndex(of: answer) {
            
            questionDetails.answers[index].state = .selected
        }
    }
    
    private func prepareQuestionsNumbers() {
        
        for i in 0..<questions.count {
            for j in 0..<questions[i].answers.count {
                questions[i].answers[j].number = answersIndexes[j]
            }
        }
        
        for j in 0..<questionDetails.answers.count {
            questionDetails.answers[j].number = answersIndexes[j]
        }
    }

    private func clearSelectedAnswer() {
        
        for i in 0..<questionDetails.answers.count {
            questionDetails.answers[i].state = .idle
        }
    }
    
    func presentDialog(for option: QBankType) {
        currentOption = option
        isPresentCustomSheetView = true
    }

    func nextAction() {
        switch addQBankSteps {
        case .first: addQBankSteps = .second
        case .second:
            addQBankSteps = .third
            getReferencePreviousExams()
            getReferencesSyllabus()
        case .third: addQBankSteps = .fourth
        case .fourth: addQBankSteps = .fifth
        case .fifth: addQBankSteps = .sixth
        case .sixth: addQBankSteps = .seventh
        case .seventh: addQBankSteps = .questions
        case .questions: addQBankSteps = .first
        }
    }

    func backAction() {
        switch addQBankSteps {
        case .first: print("Exit")
        case .second: addQBankSteps = .first
        case .third: addQBankSteps = .second
        case .fourth: addQBankSteps = .third
        case .fifth: addQBankSteps = .fourth
        case .sixth: addQBankSteps = .fifth
        case .seventh: addQBankSteps = .sixth
        case .questions: addQBankSteps = .seventh
        }
    }
}

extension AddQBankViewModel {
    func onUploadPhotoClick() {
        sourceType = .photos
        imagePickerPresenting = true
    }

    func onChangeImageClick() {
        sourceType = .photos
        imagePickerPresenting = true
    }

    func loadExcelFile(at url: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let result = try self.excelReader.readExcelFile(at: url)
                DispatchQueue.main.async {
                    if result.msg.isEmpty {
                        self.questions = result.list
                        self.displayedreferencesSyllabus = Array(repeating: self.referencesSyllabus, count: self.questions.count)
                        self.parentReferencesSyllabus = Array(repeating: nil, count: self.questions.count)
                        self.fileName = result.fileName
                    } else {
                        showErrorToast(message: result.msg)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    showErrorToast(error: error)
                }
            }
        }
    }

    func onDurationDateType() {
        isShowDurationDate = true
    }

    func selectDurationType(_ type: DurationDateType) {
        selectedDurationDate = type
        durationType = type.displayName
        isShowDurationDate = false
    }
}

extension AddQBankViewModel {
    func previewQuestionTapped() {
        addQBankSteps = .seventh
    }
    
    func onFinishAndPublishTapped() {
        createQBank()
    }
    
    func nextButtonAction() -> EmptyAction {
        addQBankSteps == .first ? exitAction : backAction
    }
    
    func exitAction() {
        coordinator.popView()
    }
}

extension AddQBankViewModel {
    
    func hideCustomSheetView() {
        isPresentCustomSheetView = false
        currentOption = nil
    }
    
    func onCertificatesSelect(certificate: Certificate) {
        
        selectedCertificate = certificate
        getReferences(certificateId: certificate.certificateId)
        
        hideCustomSheetView()
    }
    
    func onReferencesSelect(reference: Reference) {
        
        selectedReference = reference
        
        referenceId = reference.referenceId
        hideCustomSheetView()
    }
    
    func onReferencePreviousExamSelect(referencePreviousExam: ReferencePreviousExam) {
        
        if currentIndex < questions.count {
            if !questions[currentIndex].previous_exam_id.contains(referencePreviousExam.examId) {
                questions[currentIndex].previous_exam_id.append(referencePreviousExam.examId)
            }
        }
        
        hideCustomSheetView()
    }
    
    func removePreviousExam(withId id: Int) {
        if currentIndex < questions.count {
            questions[currentIndex].previous_exam_id.removeAll { $0 == id }
        }
        
        if let index = referencePreviousExams.firstIndex(where: { $0.examId == id }) {
            referencePreviousExams.remove(at: index)
        }
    }
    
    func removeInvalidExams(from question: QuestionBankQuestionModel) {
        guard questions.indices.contains(currentIndex) else { return }
        let invalidExamIds = questions[currentIndex].previous_exam_id.filter { examId in
            !referencePreviousExams.contains { $0.examId == examId }
        }
        
        questions[currentIndex].previous_exam_id.removeAll(where: { invalidExamIds.contains($0) })
    }
    
    func onReferenceSyllabussBackClick() {
        if let parentId = parentReferencesSyllabus[currentIndex]?.referenceSyllabusId {
            
            parentReferencesSyllabus[currentIndex] = ReferenceSyllabus.getReferenceSyllabus(id: parentId, in: referencesSyllabus) ?? nil
            
        } else {
            
            parentReferencesSyllabus[currentIndex] = nil
        }
        
        displayedreferencesSyllabus[currentIndex] = parentReferencesSyllabus[currentIndex]?.children ?? referencesSyllabus
    }
    
    func onReferenceSyllabusSelect(syllabus: ReferenceSyllabus) {
        if !syllabus.children.isEmpty {
            displayedreferencesSyllabus[currentIndex] = syllabus.children
            parentReferencesSyllabus[currentIndex] = syllabus
            
        } else {
            hideCustomSheetView()
            questions[currentIndex].reference_syllabus_id = syllabus.referenceSyllabusId
            questions[currentIndex].reference_syllabus = syllabus
        }
    }
    
    func onReferenceSyllabusDoneClick(syllabus: ReferenceSyllabus) {
        questions[currentIndex].reference_syllabus = syllabus
        hideCustomSheetView()
    }
    
    func onQuestionTapped() {
        addQBankSteps = .seventh
    }
}

// MARK: - Check Validation -

extension AddQBankViewModel {
    func checkPreviousExam(question: QuestionBankQuestionModel) -> Bool {
        print(question.previous_exam_id.isEmpty , question.previous_exam_id)
        if question.previous_exam_id.first == 0 {
            return true
        } else {
            let matchesPreviousExams = referencePreviousExams.contains(where: { exam in question.previous_exam_id.contains(exam.examId) })
            return matchesPreviousExams
        }
    }
    
    func checkReferenceSyllabus(question: QuestionBankQuestionModel) -> Bool {
        if question.reference_syllabus_id == 0 {
            return true
        } else {
            let matchesReferenceSyllabus = flatReferencesSyllabus.contains(where: { $0.referenceSyllabusId == question.reference_syllabus_id && $0.children.isEmpty })
            return matchesReferenceSyllabus
        }
    }
}

// MARK: - Get Certificates

extension AddQBankViewModel: UseCaseViewModel {
    
    private func getCertificates() {
        do {
            qbankLoadingState = .loading
                        
            let getCertificates = GetCertificates(fieldIds: [], institutionIds: [])
            
            try getCertificatesUseCase.execute(with: getCertificates)
                .sink(receiveCompletion: handleGetGlobalsCompletion,
                      receiveValue: handleGetCertificatesResult)
                .store(in: &cancellables)
        } catch {
            showToast(message: error.localizedDescription)
        }
    }
    
    func handleGetGlobalsCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            qbankLoadingState = .failed
        }
    }
    
    func handleGetCertificatesResult(result: DomainWrapper<[Certificate]>) {
        qbankLoadingState = .loaded
        
        if result.isSuccess, let certificates = result.data {
            self.certificates = certificates
        } else {
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        qbankLoadingState = .failed
    }
}

// MARK: - Get References

extension AddQBankViewModel {
    
    private func getReferences(certificateId: Int) {
        do {
            qbankLoadingState = .loading
            
            let getReferences: GetReferences = GetReferences(certificateIds: [certificateId])
            
            try getReferencesUseCase.execute(with: getReferences)
                .sink(receiveCompletion: handleGetGlobalsCompletion,
                      receiveValue: handleGetFieldsResult)
                .store(in: &cancellables)
        } catch {
            showToast(message: error.localizedDescription)
        }
    }
    
    func handleGetFieldsResult(result: DomainWrapper<[Reference]>) {
        qbankLoadingState = .loaded
        
        if result.isSuccess, let references = result.data {
            self.references = references
        } else {
            showErrorToast(message: result.message)
        }
    }
}

// MARK: - Get ReferencePreviousExams

extension AddQBankViewModel {
    
    private func getReferencePreviousExams() {
        do {
            qbankLoadingState = .loading
                        
            let getReferencePreviousExams = GetReferencePreviousExams(referenceIds: [], parentIds: [])
            
            try getReferencePreviousExamsUseCase.execute(with: getReferencePreviousExams)
                .sink(receiveCompletion: handleGetGlobalsCompletion,
                      receiveValue: handleGetReferencePreviousExamResult)
                .store(in: &cancellables)
        } catch {
            showToast(message: error.localizedDescription)
        }
    }
    
    func handleGetReferencePreviousExamResult(result: DomainWrapper<[ReferencePreviousExam]>) {
        qbankLoadingState = .loaded
        
        if result.isSuccess, let referencePreviousExams = result.data {
            self.referencePreviousExams = referencePreviousExams
        } else {
            showErrorToast(message: result.message)
        }
    }
}

// MARK: - Get ReferencesSyllabus

extension AddQBankViewModel {
    
    private func getReferencesSyllabus() {
        do {
            qbankLoadingState = .loading
                        
            let getReferencesSyllabus = GetReferenceSyllabi(referenceIds: [], parentIds: [])
            
            try getReferenceSyllabiUseCase.execute(with: getReferencesSyllabus)
                .sink(receiveCompletion: handleGetGlobalsCompletion,
                      receiveValue: handleGetReferencesSyllabusResult)
                .store(in: &cancellables)
        } catch {
            showToast(message: error.localizedDescription)
        }
    }
    
    func handleGetReferencesSyllabusResult(result: DomainWrapper<[ReferenceSyllabus]>) {
        qbankLoadingState = .loaded
        
        if result.isSuccess, let referencesSyllabus = result.data {
            self.referencesSyllabus = referencesSyllabus
            self.displayedreferencesSyllabus.append(referencesSyllabus)
            self.flatReferencesSyllabus = flattenSyllabus(referencesSyllabus)
        } else {
            showErrorToast(message: result.message)
        }
    }
    
    func flattenSyllabus(_ syllabus: [ReferenceSyllabus]) -> [ReferenceSyllabus] {
        return syllabus.flatMap { [ $0 ] + flattenSyllabus($0.children) }
    }
}

// MARK: - Create Course -

extension AddQBankViewModel {
    func createQBank() {
        do {
            qbankLoadingState = .loading
            
            let qBankModel = CreateQBank(
                name: qbankTitle,
                uuid: qbankId,
                image: didSelectImage ? qbankImage.imageData : nil,
                price: Double(qbankPrice) ?? 0.0,
                duration: isShowExpirationDate ? Int(durationDate) : nil,
                isVisible: 1,
                overview: qbankOverview,
                referenceId: referenceId,
                trialDuration: isEnableTrial ? Int(durationTrial) : nil,
                questions: questions
            )
            
            try createQBankUseCase.execute(params: qBankModel)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleCreateCourseResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func handleCreateCourseResult(result: DomainWrapper<CreateQBankResponse>) {
        qbankLoadingState = .loaded
        
        if result.isSuccess {
            showSuccessToast(message: result.message)
        } else {
            print(result.message)
            showErrorToast(message: result.message)
        }
    }
    
    func handleSecretriesCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            qbankLoadingState = .failed
        }
    }
}
