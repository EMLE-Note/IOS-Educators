//
//  AddNewCourseViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/09/2024.
//

import Foundation
import EMLECore
import Combine
import SwiftUI

class AddNewCourseViewModel: MainViewModel {
    
    let coordinator: AddNewCourseViewCoordinating

    // MARK: - Initializer
    init(coordinator: AddNewCourseViewCoordinating) {
        self.coordinator = coordinator
    }
    
    @Published var addCourseSteps: AddCourseSteps = .first
    @Published var courseId = ""
    @Published var courseTitle = ""
    @Published var coursePrice = ""
    @Published var courseOverview = ""
    @Published var group = ""
    @Published var courseSchedule = ""
    @Published var isPublicExplore = false
    @Published var isPresentCustomSheetView: Bool = false
    @Published var imagePickerPresenting = false
    @Published var selectedGroups: [GroupCourse] = [] {
        didSet {
            selectedGroupIds = selectedGroups.map { $0.groupId }
        }
    }
    @Published var allGroups: [GroupCourse] = []
    @Published var selectedGroupIds: [Int] = []
    @Published var isPresentGroupSheetView: Bool = false
    @Published var isShowPrice: Bool = true
    @Published var isShowStudentCount: Bool = true
    
    @Published var newTarget: Target = .placeholder
    @Published var currentOption: TargetedLearnersType?
    @Published var showOnCourseExplore: Bool = false
    @Published var isExpandableStates: [Bool] = []
    @Published var parentField: StudyingField?
    @Published var fields: [StudyingField] = []
    @Published var displayedFields: [StudyingField] = []
    @Published var selectedField: StudyingField = .emptyPlaceholder
    @Published var educationStatuses: [EducationStatus] = []
    @Published var educationStatusSelected: EducationStatus = .emptyPlaceholder
    @Published var institution: [Institution] = []
    @Published var selectedInstitution: Institution = .emptyPlaceholder
    
    @Published var currentIndex: Int? = nil
    
    @Published var isPickerVisible: Bool = false
    
    @Published var publishDate: String = ""
    @Published var duration: String = ""
    
    @Published var courseLoadingState: LoadingState = .loaded
    
    @Published var isLearnerSignatureSelected: Bool = true
    @Published var isFingerprintSelected: Bool = true
    @Published var isFaceRecognitionSelected: Bool = true
    @Published var isStudentNameAudioSelected: Bool = true
    @Published var isPreventScreenRecordSelected: Bool = true
    @Published var isNotificationSecuritySelected: Bool = false
    @Published var isHeadphoneSecuritySelected: Bool = false
    @Published var isNationalIDVerificationSelected: Bool = false
    @Published var fontSize: String = "16"
    @Published var fontSizeValue: Int = 16
    @Published var fontweight: String = "400"
    @Published var fontweightValue: Int = 400
    @Published var playSound: String = "20"
    @Published var playSoundValue: Int = 20
    @Published var fingerPrint: String = "20"
    @Published var fingerPrintValue: Int = 20
    
    @Published var selectedDateOption: ExpirationDateType = .nothaveExpirationDate
    @Published var selectedAccessCourse: AccessCourseType = .allowOnline
    
    @Published var isPressentedDialog: Bool = false
    @Published var selectedSecurityOption: SecurityOptionType?
    @Published var isPresentSheetView: Bool = false
    @Published var currentAction: SecurityAction?
    
    @Published var selectedFontWeight: FontWeight = .regular
    @Published var fontWeights: [FontWeight] = FontWeight.allCases
    
    @Published var selectedFontSize: FontSize = .size16
    @Published var fontSizes: [FontSize] = FontSize.allCases
    
    @Published var selectedFingerPrintTimeInterval: DurationOption = .tenMinutes
    @Published var selectedPlaySoundTimeInterval: DurationOption = .tenMinutes
    @Published var timeIntervals: [DurationOption] = DurationOption.allCases
    
    @Published var courseImage: ImagePickerImage = .empty {
        didSet {
            didSelectImage = true
        }
    }
 
    var isTabBarVisible: Bool { false }
    
    var cancellables = Set<AnyCancellable>()
    var sourceType: ImagePickerSourceType = .photos
    var didSelectImage = false
    
    var isNextButtonEnabledFirst: Bool {
        !courseId.isEmpty && !courseTitle.isEmpty && !coursePrice.isEmpty && !courseOverview.isEmpty
    }
    
    var targets: [Target] = []
    
    var canAddNewTarget: Bool {
        !newTarget.name.isEmpty &&
        (!newTarget.field.displayName.isEmpty ||
         !newTarget.type.displayName.isEmpty )
    }
    
    @Inject var getGlobalIndexUseCase: GetGlobalIndexUseCase
    @Inject var getGroupUseCase: GetGroupUseCase
    @Inject var createCourseUseCase: CreateCourseUseCase
}

extension AddNewCourseViewModel {
    func onAppear() {
        getGlobals()
    }
    
    func presentDialog(for option: TargetedLearnersType) {
        currentOption = option
        isPresentCustomSheetView = true
    }
    
    func onSelectedNewGroupsTapped() {
        getGroups()
        withAnimation {
            isPresentGroupSheetView = true
        }
    }
    
    func onRemoveGroupTapped(group: GroupCourse) {
        if let index = selectedGroups.firstIndex(where: { $0.groupId == group.groupId }) {
            selectedGroups.remove(at: index)
        }
    }
    
    func addAntherTargetTapped() {
        if !newTarget.name.isEmpty {
            targets.append(newTarget)
            showOnCourseExplore = true
            self.isExpandableStates = Array(repeating: true, count: self.targets.count)
            newTarget = .placeholder
        }
    }
    
    func hideCustomSheetView() {
        isPresentCustomSheetView = false
        currentOption = nil
    }
    
    func onFieldsBackClick() {
        if let parentId = parentField?.parentId {
            
            parentField = StudyingField.getStudyingField(id: parentId, in: fields)
        } else {
            
            parentField = nil
        }
        
        displayedFields = parentField?.children ?? fields
    }
    
    func onFieldSelect(field: StudyingField) {
        if !field.children.isEmpty {
            displayedFields = field.children
            parentField = field
        } else {
            hideCustomSheetView()
            selectedField = field
            
            newTarget.field = field
        }
    }
    
    func onFieldsDoneClick(field: StudyingField) {
        selectedField = field
        hideCustomSheetView()
        
        newTarget.field = field
    }
    
    func onEducationStatusSelect(educationStatus: EducationStatus) {
        educationStatusSelected = educationStatus
        hideCustomSheetView()
        
        newTarget.type = educationStatus
    }
    
    func onInstitutionSelect(institution: Institution) {
        selectedInstitution = institution
        hideCustomSheetView()
        
        newTarget.institution = institution
    }
    
    func onClickedFontSize() {
        currentAction = .fontSize
        withAnimation {
            isPresentCustomSheetView = true
        }
    }
    
    func onClickedFontWeight() {
        currentAction = .fontWeight
        withAnimation {
            isPresentCustomSheetView = true
        }
    }
    
    func onClickedVerifyIdentity() {
        currentAction = .verifyIdentity
        withAnimation {
            isPresentCustomSheetView = true
        }
    }
    
    func onClickedPlaySound() {
        currentAction = .playSound
        withAnimation {
            isPresentCustomSheetView = true
        }
    }
    
    func presentDialog(for option: SecurityOptionType) {
        selectedSecurityOption = option
        isPressentedDialog = true
    }
    
    func selectFontSize(_ fontSize: FontSize) {
        self.selectedFontSize = fontSize
        self.fontSize = selectedFontSize.displayName
        self.fontSizeValue = selectedFontSize.rawValue
        withAnimation {
            isPresentCustomSheetView = false
        }
    }
    
    func selectFontWeight(_ fontWeight: FontWeight) {
        self.selectedFontWeight = fontWeight
        self.fontweight = selectedFontWeight.displayName
        self.fontweightValue = selectedFontWeight.value
        withAnimation {
            isPresentCustomSheetView = false
        }
    }
    
    func selectPlaySoundDurationOption(_ timeInterval: DurationOption) {
        self.selectedPlaySoundTimeInterval = timeInterval
        self.playSound = selectedPlaySoundTimeInterval.displayName
        self.playSoundValue = selectedPlaySoundTimeInterval.rawValue
        withAnimation {
            isPresentCustomSheetView = false
        }
    }
    
    func selectFingerPrintDurationOption(_ timeInterval: DurationOption) {
        self.selectedPlaySoundTimeInterval = timeInterval
        self.fingerPrint = selectedPlaySoundTimeInterval.displayName
        self.fingerPrintValue = selectedPlaySoundTimeInterval.rawValue
        withAnimation {
            isPresentCustomSheetView = false
        }
    }
    
    func onChangeImageClick() {
        sourceType = .photos
        imagePickerPresenting = true
    }
    
    func nextButtonAction() -> EmptyAction {
        addCourseSteps == .first ? exitAction : backAction
    }
    
    func finishAndPublishTapped() {
        createCourse()
    }
}

// MARK: - Action button -

extension AddNewCourseViewModel {
    
    func NextButtonAction() -> EmptyAction {
        addCourseSteps == .first ? exitAction : backAction
    }
    
    func exitAction() {
        print("Exit Action")
    }
    
    func nextAction() {
        switch addCourseSteps {
        case .first: addCourseSteps = .second
        case .second: addCourseSteps = isPublicExplore ? .third : .fourth
        case .third: addCourseSteps = .fourth
        case .fourth: addCourseSteps = .fifth
        case .fifth: addCourseSteps = .sixth
        case .sixth: addCourseSteps = .seventh
        case .seventh: addCourseSteps = .first
        }
    }

    func backAction() {
        switch addCourseSteps {
        case .first: print("Exit")
        case .second: addCourseSteps = .first
        case .third: addCourseSteps = .second
        case .fourth: addCourseSteps = isPublicExplore ? .third : .second
        case .fifth: addCourseSteps = .fourth
        case .sixth: addCourseSteps = .fifth
        case .seventh: addCourseSteps = .sixth
        }
    }
}

// MARK: - get Globals requests -

extension AddNewCourseViewModel: UseCaseViewModel {
    
    private func getGlobals() {
        do {
            courseLoadingState = .loading
            
            let getGlobalIndex = GetGlobalIndex(types: GlobalIndexType.allCases)
            
            try getGlobalIndexUseCase.execute(with: getGlobalIndex)
                .sink(receiveCompletion: handleGetGlobalsCompletion,
                      receiveValue: handleGetFieldsResult)
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
            courseLoadingState = .failed
        }
    }
    
    func handleGetFieldsResult(result: DomainWrapper<GlobalIndex>) {
        courseLoadingState = .loaded
        
        if result.isSuccess,
           let studyingFields = result.data?.studyingFields,
           let types = result.data?.types, let institution = result.data?.institutions {
            fields = studyingFields
            displayedFields = fields
            self.educationStatuses = types
            self.institution = institution
        } else {
            showErrorToast(message: result.message)
        }
    }
    
    func handleUseCaseFailure(error: UseCaseError) {
        courseLoadingState = .failed
    }
}

// MARK: - Get Groups -

extension AddNewCourseViewModel {
    func getGroups() {
        do {
            try getGroupUseCase.execute()
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleGroupsRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleGroupsRequestsResult(groups: DomainWrapper<[GroupCourse]>) {
        courseLoadingState = .loaded
        
        if groups.isSuccess, let groups = groups.data {
            self.allGroups = groups
        } else {
            print(groups.message)
            showErrorToast(message: groups.message)
        }
    }
    
    func handleSecretriesCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            courseLoadingState = .failed
        }
    }
}

// MARK: - Create Course -

extension AddNewCourseViewModel {
    func createCourse() {
        do {
            courseLoadingState = .loading
            
            let targetRequestForms = targets.map { target in
                target.toTargetRequestForm(studentsCount: 0)
            }
            
            let signature = Signature(fontSize: isLearnerSignatureSelected ? fontSizeValue : nil, fontWeight: isLearnerSignatureSelected ? fontweightValue : nil)
            let security = Security(fingerPrintTime: isFingerprintSelected ? fingerPrintValue : 0, studentNameTime: isStudentNameAudioSelected ? playSoundValue : 0, preventScreenRecord: isPreventScreenRecordSelected, notificationSecurity: isNotificationSecuritySelected, headphoneSecurity: isHeadphoneSecuritySelected, nationalIdSecurity: isNationalIDVerificationSelected, faceRecognitionSecurity: isFaceRecognitionSelected, signature: signature)
            
            let body = CreateCourseRequestFrom(uuid: courseId, name: courseTitle, image: didSelectImage ? courseImage.imageData : nil, overview: courseOverview, duration: selectedDateOption == .hasExpirationDate ? duration : nil, expireAt: nil, publishAt: isPublicExplore ? publishDate : nil, isVisible: 1, isAllowedOffline: selectedAccessCourse == .allowOffline ? 0 : 1, targets: targetRequestForms, price: Double(coursePrice) ?? 1.0, security: security, groups: selectedGroupIds)
            
            print(body)
            try createCourseUseCase.execute(body: body)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleCreateCourseResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func handleCreateCourseResult(result: DomainWrapper<Course>) {
        courseLoadingState = .loaded
        
        if result.isSuccess {
            showSuccessToast(message: result.message)
            coordinator.popView()
        } else {
            print(result.message)
            showErrorToast(message: result.message)
        }
    }
}
