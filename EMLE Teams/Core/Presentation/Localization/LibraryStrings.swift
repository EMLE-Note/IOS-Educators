//
//  LibarayStrings.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 24/08/2024.
//

import Foundation
import EMLECore

enum LibraryStrings: String, Localizable  {
    var tableName:String {
        return "LibarayStrings"
    }
    case course = "course"
    case EBooks = "E_books"
    case QBank = "Q_Bank"
    case drafts = "drafts"
    case addNewGroup = "add_new_group"
    case addNewCourse = "add_new_course"
    case folder = "folder"
    case youHaveNoCourses = "you_have_no_course"
    case createNewCourse = "create_new_course"
    case groupName = "group_name"
    case name = "name"
    case create = "create"
    case latestToOldest = "latest_to_oldest"
    case oldestToLatest = "oldest_to_latest"
    case activated = "activated"
    case deactivated = "deactivated"
    case hideFolder = "hide_folder"
    case showFolder = "show_folder"
    case deletePermanently = "delete_permanently"
    case editSecurityLayers = "edit_security_layers"
    case deactivate = "deactivate"
    case activate = "activate"
    case hideFolderFromCourse = "hide_the_folder_from_the_course"
    case showFolderFromCourse = "show_the_folder_from_the_course"
    case deleteFilesFromServers = "delete_files_from_servers"
    case adjustSecurityLayers = "adjust_security_layers"
    case disableLearnerAccessCourse = "disable_learner_access_course"
    case enableLearnerAccessCourse = "enable_learner_access_course"
    
    case content
    case student
    case activateAll = "activate_all"
    case deactivateAll = "deactivate_all"
    case addNewParentFolder = "add_new_parent_folder"
    case createFolder = "create_folder"
    case addLessonFolder = "add_lesson_folder"
    case students
    case startBuildingCourse = "start_building_course"
    case youDontHaveStudent = "you_dont_have_students"
    case filter
    case sortBy
    case status
    case applyChanges = "apply_Changes"
    case discardChanges = "discard_Changes"
    case createParentFolder = "create_parent_folder"
    case createLessonFolder = "create_lesson_folder"
    
    case delete
    case parentFolderName = "parent_folder_name"
    case folderName = "folder_name"
    
    case courseSetting = "course_setting"
    case targetLearner = "target_learner"
    case protectionLayer = "protection_layers"
    case visibility
    case activateCourse = "activate_course"
    case deactivateCourse = "deactivate_course"
    case allowOfflineWatching = "allow_offline_watching"
    
    case courseImage = "course_image"
    case changeImage = "change_image"
    case maximumPicSize = "maximum_pic_size"
    case courseId = "course_id"
    case courseTitle = "course_title"
    case price
    case courseOverview = "course_overview"
    case expirtationDur = "expirtation_dur"
    case groups
    case selectNewGroup = "select_new_group"
    
    case learnerSignature = "learner_signature"
    case fontSize
    case fontWeight
    case fingerprint
    case verifyIdentityEvery
    case faceRecognition
    case studentNameAudio
    case playSound
    case preventScreen
    case notificationSecurity
    case headphoneSecurity
    case nationalIdVerification
    
    case learnerSignatureMessage
    case fingerprintMessage
    case verifyIdentityEveryMessage
    case faceRecognitionMessage
    case studentNameAudioMessage
    case playSoundMessage
    case preventScreenMessage
    case notificationSecurityMessage
    case headphoneSecurityMessage
    case nationalIdVerificationMessage
    
    case editCourse
    
    
    case onlyCanViewCourse
    case courseWillBeVisibleAnyone
    case Private
    case Public
    case schedule
    case publishAsPublic
    case selectDate
    case publishNow
    
    case showCourseExplore
    case addTarget
    case putDescriptiveTitle
    case field
    case selectStudyFiled
    case educationalStatus
    case selectEductionalStatus
    case selectLocation
    case university
    case selectUniversity
    
    // Add QBank
    case addYourQbnk
    case makeItEasierForStudentsToFind
    case specifyTheExpirationDate
    case getMoreSalse
    case uploadYourQBankCover
    case importQbank
    case checkInvalidQuestionVerifiction
    case weRecommendYouToAddThumbnailForQbank
    case youCanImportYourQuestionBank
    
    case back
    case next
    case previous
    case qbankId
    case qbankTitle
    case qbankPrice
    case qbankOverview
    case qbankIdPH
    case qbankTitlePH
    case qbankPricePH
    case qbankOverviewPH
    
    case certificate
    case reference
    case expirationDate
    case durationOfQBank
    case durationOfQBankPH
    case days
    case enableTrial
    case durationOfTrial
    case durationOfTrialPH
    case downloadSampleTemplate
    case previewQuestion
    case finishAndPublish
    case answers
    case previousExam
    case addPreviousExam
    case referencesSyllabi
    case selectSyllabi
    case addNewQBank
    
    case uploadExcelFile
    case abcde
    
    case editQuestionBank
    case qbankSettings
    case question
    
    case courseIdPH
    case courseIdError
    case courseTitlePH
    case coursePricePH
    case courseOverviewPH
    case courseExpirationDatePH
    
    case saveAsDraft
    case doesNotHaveExpirationDate
    case hasExpirationDate
    case allowOfflineAccess
    case allowOnlineAccess
    
    case addYourCourseSettings
    case makeItEasierStudentCourse
    case seheduleCourse
    case addCourseExpirationDate
    case allowOffline
    case selectCourseProtectionLayer
    case uploadYourCourseImage
    case controlWhenYourContentLivePublished
    case weRecommendYouToEnableOffline
    case weRecommendYouAddThumbnailForCourse
    
    case deleteQBankPermanently
    
    case emleServer
    case otherProviders
    
    case lesson
    case free
    case youtube
    case googleDrive
    case vimeo
    case publit
    case videoName
    case selectVideo
    case pasteVideoLink
    case upload
    
    case downloadMaterial
    case editMaterial
    case hideLesson
    case copyLesson
    case setasFree
    case deleteLesson
    case hidenTheLessonCourse
    case copyTheLessonAntherCourse
    case encouageLearners
    case deleteYouLessonFile
    
    case DQuiz = "%d quiz"
    case DBook = "%d Book"
}
