//
//  ProtectionLayerViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 15/08/2024.
//

import Foundation
import EMLECore
import SwiftUI
import Combine

class ProtectionLayerViewModel: MainViewModel {
    let coordinator: ProtectionLayerViewCoordinating
    let courseId: Int?
    let securityType: SecurityType
    let security: Security?
    
    init(courseId: Int? = nil, securityType: SecurityType, security: Security? = nil, coordinator: ProtectionLayerViewCoordinating) {
        self.coordinator = coordinator
        self.courseId = courseId
        self.securityType = securityType
        self.security = security
    }
    
    var isTabBarVisible: Bool { false }
    var cancellables = Set<AnyCancellable>()
    
    @Inject var contentDataUseCase: ContentDataUseCase
    @Inject var editCourseSecurityUseCase: EditCourseSecurityUseCase
    
    @Published var courseData: Course?
    @Published var isLearnerSignatureSelected: Bool = false
    @Published var isFingerprintSelected: Bool = false
    @Published var isFaceRecognitionSelected: Bool = false
    @Published var isStudentNameAudioSelected: Bool = false
    @Published var isPreventScreenRecordSelected: Bool = false
    @Published var isNotificationSecuritySelected: Bool = false
    @Published var isHeadphoneSecuritySelected: Bool = false
    @Published var isNationalIDVerificationSelected: Bool = false
    @Published var fontSize: String = ""
    @Published var fontSizeValue: Int = 0
    @Published var fontweight: String = ""
    @Published var fontweightValue: Int = 0
    @Published var playSound: String = ""
    @Published var playSoundValue: Int = 0
    @Published var fingerPrint: String = ""
    @Published var fingerPrintValue: Int = 0
    @Published var contentLoadingState: LoadingState = .loaded
    @Published var isPressentedDialog: Bool = false
    @Published var selectedSecurityOption: SecurityOptionType?
    @Published var isPresentCustomSheetView: Bool = false
    @Published var currentAction: SecurityAction?
    
    @Published var selectedFontWeight: FontWeight = .regular
    @Published var fontWeights: [FontWeight] = FontWeight.allCases
    
    @Published var selectedFontSize: FontSize = .size16
    @Published var fontSizes: [FontSize] = FontSize.allCases
    
    @Published var selectedFingerPrintTimeInterval: DurationOption = .tenMinutes
    @Published var selectedPlaySoundTimeInterval: DurationOption = .tenMinutes
    @Published var timeIntervals: [DurationOption] = DurationOption.allCases
}

extension ProtectionLayerViewModel {
    func onAppear() {
        switch securityType {
        case .course:
            fetchCourse(courseId: courseId ?? -1)
        case .student:
            setupSecurityData()
        }
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
    
    func onApplyChangeClick() {
        updateCourse(courseId: courseId ?? -1)
    }
    
    func onDiscardChangeClick() {
        coordinator.popView()
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
    
    func displayName(forWeightValue value: Int) -> String {
        if let fontWeight = FontWeight.fontWeight(for: value) {
            self.selectedFontWeight = fontWeight
            self.fontweightValue = selectedFontWeight.value
            return fontWeight.rawValue
        } else {
            return "Invalid font weight"
        }
    }
}

// MARK: - get Content requests -

extension ProtectionLayerViewModel {
    func fetchCourse(courseId: Int) {
        do {
            let filters: GetContentFilterRequest = .empty
            print(filters)
            
            try contentDataUseCase.execute(courseId: courseId)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleContentRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleSecretriesCompletion(completion: Subscribers.Completion<UseCaseError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error: \(error)")
            showErrorToast(error: error)
            contentLoadingState = .failed
        }
    }
    
    func handleContentRequestsResult(contentRequests: DomainWrapper<Course>) {
        contentLoadingState = .loaded
        
        if contentRequests.isSuccess {
            self.courseData = contentRequests.data
            if let fontSize = courseData?.security.signature?.fontSize, let fontWeight = courseData?.security.signature?.fontWeight, let faceRecognitionSecurity = courseData?.security.faceRecognitionSecurity, let preventScreenRecord = courseData?.security.preventScreenRecord, let notificationSecurity = courseData?.security.notificationSecurity, let headphoneSecurity = courseData?.security.headphoneSecurity, let nationalIDSecurity = courseData?.security.nationalIdSecurity, let fingerPrintTime = courseData?.security.fingerPrintTime, let studentNameTime = courseData?.security.studentNameTime {
                self.fontSize = "\(fontSize)"
                self.fontSizeValue = fontSize
                self.fontweight = "\(displayName(forWeightValue: fontWeight))"
                self.fingerPrint = "\(fingerPrintTime)"
                self.fingerPrintValue = fingerPrintTime
                self.playSound = "\(studentNameTime)"
                self.playSoundValue = studentNameTime
                isLearnerSignatureSelected =  courseData?.security.signature != nil
                isFingerprintSelected = faceRecognitionSecurity
                isFaceRecognitionSelected = faceRecognitionSecurity
                isStudentNameAudioSelected = (studentNameTime != 0)
                isPreventScreenRecordSelected = preventScreenRecord
                isNotificationSecuritySelected = notificationSecurity
                isHeadphoneSecuritySelected = headphoneSecurity
                isNationalIDVerificationSelected = nationalIDSecurity
            }
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}

// MARK: - Setup Student Date -

extension ProtectionLayerViewModel {
    private func setupSecurityData() {
        if let security = security, let fontSize = security.signature?.fontSize, let fontWeight = security.signature?.fontWeight, let faceRecognitionSecurity = security.faceRecognitionSecurity, let preventScreenRecord = security.preventScreenRecord, let notificationSecurity = security.notificationSecurity, let headphoneSecurity = security.headphoneSecurity, let nationalIDSecurity = security.nationalIdSecurity, let fingerPrintTime = security.fingerPrintTime, let studentNameTime = security.studentNameTime {
            self.fontSize = "\(fontSize)"
            self.fontSizeValue = fontSize
            self.fontweight = "\(displayName(forWeightValue: fontWeight))"
            self.fingerPrint = "\(fingerPrintTime)"
            self.fingerPrintValue = fingerPrintTime
            self.playSound = "\(studentNameTime)"
            self.playSoundValue = studentNameTime
            isLearnerSignatureSelected =  courseData?.security.signature != nil
            isFingerprintSelected = faceRecognitionSecurity
            isFaceRecognitionSelected = faceRecognitionSecurity
            isStudentNameAudioSelected = (studentNameTime != 0)
            isPreventScreenRecordSelected = preventScreenRecord
            isNotificationSecuritySelected = notificationSecurity
            isHeadphoneSecuritySelected = headphoneSecurity
            isNationalIDVerificationSelected = nationalIDSecurity
        }
    }
}

// MARK: - Update Course -

extension ProtectionLayerViewModel {
    func updateCourse(courseId: Int) {
        do {
            
            let signature = Signature(fontSize: isLearnerSignatureSelected ? fontSizeValue : nil, fontWeight: isLearnerSignatureSelected ? fontweightValue : nil)
            let security = Security(fingerPrintTime: isFingerprintSelected ? fingerPrintValue : 0, studentNameTime: isStudentNameAudioSelected ? playSoundValue : 0, preventScreenRecord: isPreventScreenRecordSelected, notificationSecurity: isNotificationSecuritySelected, headphoneSecurity: isHeadphoneSecuritySelected, nationalIdSecurity: isNationalIDVerificationSelected, faceRecognitionSecurity: isFaceRecognitionSelected, signature: signature)
            
            let body = EditCourseSecurityParameter(courseId: courseId, security: security)
            
            try editCourseSecurityUseCase.execute(params: body)
                .sink(receiveCompletion: handleSecretriesCompletion,
                      receiveValue: handleUpdateFolderRequestsResult)
                .store(in: &cancellables)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func handleUpdateFolderRequestsResult(contentRequests: DomainWrapper<Course>) {
        contentLoadingState = .loaded
        
        if contentRequests.isSuccess {
            showSuccessToast(message: contentRequests.message)
            coordinator.popView()
        } else {
            print(contentRequests.message)
            showErrorToast(message: contentRequests.message)
        }
    }
}
