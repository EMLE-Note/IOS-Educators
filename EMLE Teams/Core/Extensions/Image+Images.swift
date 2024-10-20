//
//  Image+Images.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//

import SwiftUI

// MARK: Common images and icons.

extension Image {
    static let uiUnderConstruction = Image("ui-under-construction-img")
    
    // status images
    static let failure = Image("failure-img")
    
    static let exclamationCircledMark = Image(systemName: "exclamationmark.circle")
    
    static let eye = Image("eye-ic")
    static let closeIcon = Image(.closeIc)
    static let closeIconWithBG = Image(.closeIcWithBG)
    static let eyeSlash = Image("eye-slash-ic")
    static let dollarImage = Image("dollar-img")
    static let moneyImage = Image("money-img")
    static let paymobLogo = Image("paymob-logo")
    static let fullLogo = Image("full-logo-img")
    static let humanUpdate = Image("human-update-img")
    static let upperVectorImage = Image("upper-vector-img")
    
    static let xMark = Image(systemName: "xmark")
    static let xMarkCircleFilled = Image(systemName: "xmark.circle.fill")
    
    static let search = Image("search-ic")
    static let settingIcon = Image("setting-ic")
    
    static let noData = Image("no-data-img")
    static let noQuestions = Image("no-questions-img")
    
    static let google  = Image("google-ic")
    static let facebook  = Image("facebook-ic")
    static let apple  = Image("apple-ic")
    
    static let chevronBackward = Image(systemName: "chevron.backward")
    
    static let shield = Image("shield-ic")
    
    static let placeholder = Image("placeholder-img")
    
    static let arrowDownFilled = Image(systemName: "arrowtriangle.down.fill")
    
    static let createAccountSuccess = Image("create-account-success-img")
    static let createTeamSuccess = Image("create-team-success-img")
    
    static let message = Image("message-ic")
    static let send = Image("send-ic")
    
    static let success = Image("success-ic")
    static let filters = Image("filters-ic")
    static let threeDots = Image("three_dots_ic")
    static let emptyIcon = Image("empty_ic")
    static let notificationIcon = Image("notification-ic")
    
    
    static let questionMark = Image(systemName: "questionmark")
    static let star = Image("star")
    static let starHalfFilled = Image("starHalfFilled")
    static let messageQuestion = Image("message-question-ic")
    static let people = Image("people-ic")
    static let contentPlaceholder = Image("content-placeholder-img")
    
    static let videoSquare = Image("video-square-ic")
    static let profile2User = Image("profile-2user-ic")
    
    static let chevronUp = Image(systemName: "chevron.up")
    static let chevronDown = Image(systemName: "chevron.down")
    
    static let chevronNext = Image(systemName: "chevron.forward")
    static let chevronPrevious = Image(systemName: "chevron.backward")
    
    static let pdf = Image("pdf-ic")
    static let book = Image("book-ic")
    
    static let aboutEMLE = Image("about-emle-ic")
    static let helpAndSupport = Image("help-and-support-ic")
    static let note = Image("note-ic")
    static let shareApp = Image("share-app-ic")
    static let userEdit = Image("user-edit-ic")
    static let chevronRight = Image(systemName: "chevron.right")
    static let logout = Image("logout-ic")
    static let x = Image("x-ic")
    static let check = Image("check-ic")
    static let share = Image("share-ic")
    static let edit = Image("edit-ic")
    static let emptyMember = Image("emptyMember-ic")
    
    static let download = Image("download-ic")
    
    static let rectangleRecord = Image(systemName: "rectangle.dashed.badge.record")
    
    static let playSpeed = Image("play-speed-ic")
    static let face = Image("face-ic")
    static let headphones = Image("headphones-img")
    static let decline = Image("decline_ic")
    static let enrollmentDetails = Image("enrollment_details_ic")
    static let resolve = Image("resolve_ic")
    static let warning = Image("warning_ic")
    
    
    
    static let emptyCourses = Image("empty_courses")
    static let eyeOff = Image("eyes_off")
    static let optianCourse = Image("optian_course")
    static let emptyContent = Image("empty_content")
    static let emptyStudent = Image("empty_student")
    static let arrow = Image("arrow")
    static let calendar = Image("calendar")
    static let deletePermanently = Image("delete_permanently")
    static let hideFolder = Image("hide_folder")
    static let editSecurityLayers = Image("edit_security_layers")
    static let deactivate = Image("deactivate")
    static let aboutLayers = Image("about_layers")
    static let coursePlaceholder = Image("course_placeholder")
    static let folderIcon = Image("folder_ic")
    static let courseSettingPlaceholder = Image("course_setting_plac")
    static let editQueation = Image("edit_queation")
    static let uploadImage = Image("upload_image")
    static let excelIcon = Image("excel_ic")
    static let downloadTem = Image("download_tem")
    static let nextIcon = Image("next_ic")
    static let backIcon = Image("back_ic")
    static let successIc = Image("success-ic")
    static let plusCircleIcon = Image(.plusCircleIc)
    
    static let materialIcon = Image("material_ic")
    static let videoIcon = Image("video_ic")
    static let addIcon = Image("add_mat")
    static let quizIcon = Image("quiz_ic")
    static let bookIcon = Image("book_ic")
    static let closeFloatIcon = Image("close_float")
    static let youtubeIcon = Image("youtube_ic")
    static let vimeoIcon = Image("vimeo_ic")
    static let publitIcon = Image("publit_ic")
    static let googleDrive = Image("google_drive")
    static let enrollmentIcon = Image("enrollment")
    static let activationEmpty = Image("activation-empty")
}


//Dashboard

extension Image {
    static let welcomeImage = Image("welcome-img")
}

// Media controls

extension Image {
    static let goForward5 = Image(systemName: "goforward.5")
    static let goBackward5 = Image(systemName: "gobackward.5")
    static let play = Image(systemName: "play.circle")
    static let replay = Image(systemName: "arrow.counterclockwise.circle")
    static let pause = Image(systemName: "pause.circle")
    static let speakerWave3 = Image(systemName: "speaker.wave.3")
    static let speakerMuted = Image(systemName: "speaker.slash")
    static let gear = Image(systemName: "gear")
    static let fullScreen = Image(systemName: "arrow.down.left.and.arrow.up.right")
    static let normalScreen = Image(systemName: "arrow.up.right.and.arrow.down.left")
}

extension Image {
    static let dashboard = Image("dashboard-ic")
    static let creditCard = Image("creditcard-img")
    static let card = Image("card-img")
    static let vodafone = Image("vodafone-img")
    static let fawry = Image("fawry-img")
}

extension UIImage {
    
    // tabbar icons
    static let dashboard = UIImage(named: "dashboard-ic")
    static let finance = UIImage(named: "finance-ic")
    static let myLibrary = UIImage(named: "my-library-ic")
    static let more = UIImage(named: "more-ic")
    static let placeholder = UIImage(named: "placeholder-img")!
}
