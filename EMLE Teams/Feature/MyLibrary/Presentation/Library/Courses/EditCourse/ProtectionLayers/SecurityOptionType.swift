//
//  SecurityOptionType.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 22/08/2024.
//

import Foundation

enum SecurityType {
    case course
    case student
}

enum SecurityOptionType {
    case learnerSignature
    case fingerprint
    case faceRecognition
    case studentNameAudio
    case preventScreenRecord
    case notificationSecurity
    case headphoneSecurity
    case nationalIDVerification

    var dialogTitle: String {
        switch self {
        case .learnerSignature:
            return LibraryStrings.learnerSignature.localized
        case .fingerprint:
            return LibraryStrings.fingerprint.localized
        case .faceRecognition:
            return LibraryStrings.faceRecognition.localized
        case .studentNameAudio:
            return LibraryStrings.studentNameAudio.localized
        case .preventScreenRecord:
            return LibraryStrings.preventScreen.localized
        case .notificationSecurity:
            return LibraryStrings.notificationSecurity.localized
        case .headphoneSecurity:
            return LibraryStrings.headphoneSecurity.localized
        case .nationalIDVerification:
            return LibraryStrings.nationalIdVerification.localized
        }
    }

    var dialogMessage: String {
        switch self {
        case .learnerSignature:
            return LibraryStrings.learnerSignatureMessage.localized
        case .fingerprint:
            return LibraryStrings.fingerprintMessage.localized
        case .faceRecognition:
            return LibraryStrings.faceRecognitionMessage.localized
        case .studentNameAudio:
            return LibraryStrings.studentNameAudioMessage.localized
        case .preventScreenRecord:
            return LibraryStrings.preventScreenMessage.localized
        case .notificationSecurity:
            return LibraryStrings.notificationSecurityMessage.localized
        case .headphoneSecurity:
            return LibraryStrings.headphoneSecurityMessage.localized
        case .nationalIDVerification:
            return LibraryStrings.nationalIdVerificationMessage.localized
        }
    }
}

enum SecurityAction {
    case fontSize
    case fontWeight
    case verifyIdentity
    case playSound
}
