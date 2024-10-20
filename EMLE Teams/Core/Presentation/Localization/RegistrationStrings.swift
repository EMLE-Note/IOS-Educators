//
//  RegistrationStrings.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 04/04/2024.
//

import Foundation
import EMLECore

enum RegistrationStrings: String, Localizable {
    
    var tableName: String {
        "RegistrationStrings"
    }
    
    //login
    case loginToYourAccount = "login_to_your_account"
    case login = "login"
    case phoneNumber = "phone_number"
    case password = "password"
    case forgetPassword = "forget_password_?"
    case doNotHaveAnAccount = "do_not_have_an_account"
    case signup = "signup"
    case phoneCodeSS = "phone_code_s_s"
    case incorrectPhoneText = "incorrect_phone_text"
    case selectYourCountry = "select_your_country"
    case noCountries = "no_countries"
    case google = "google"
    case facebook = "facebook"
    case apple = "apple"
    case email = "email"
    
    //signup
    case createNewAccount = "create_new_account"
    case continueCase = "continue"
    case haveAnAccount = "have_an_account"
    case orWith = "or_with"
    case continueWithTelegram = "continue_with_telegram"
    case continueWithSMS = "continue_with_s_m_s"
    
    //verification
    case verifyYourAccount = "verify_your_account"
    case weHaveSentVerificationCodeToTelegramS = "we_have_sent_verification_code_to_telegram_s"
    case weHaveSentSmsWithVerificationCodeS = "we_have_sent_sms_with_verification_code_s"
    case didNotGetTheCode = "did_not_get_the_code"
    case doNotHaveTelegram = "do_not_have_telegram"
    case sendViaSMS = "send_via_SMS"
    case sendViaTelegram = "send_via_telegram"
    case openTelegramAgain = "open_telegram_again"
    
    //create password
    case createPassword = "create_password"
    case confirmPassword = "confirm_password"
    case byClickingContinueYouAgreeAndAcknowledge = "by_clicking_continue_you_agree_and_acknowledge"
    case the = "the"
    case privacyPolicy = "privacy_policy"
    case and = "and"
    case termsConditions = "terms_conditions"
    case incorrectPassword = "incorrect_password"
    case passwordsAreNotIdentical = "passwords_are_not_identical"
    
    //complete your profile
    case tellUsYourName = "tell_us_your_name"
    case justTellUsWhatYouWantUsToCallYou = "just_tell_us_what_you_want_us_to_call_you"
    case name = "name"
    case jobTitle = "job_title"
    case specialization = "specialization"
    case enterYourDataToMakeItEasier = "enter_your_data_to_make_it_easier"
    case addOverview = "add_overview"
    case tellYourStudentsMoreAboutYourAcademic = "tell_your_students_more_about_your_academic"
    case uploadYourPhoto = "upload_your_photo"
    case choosePhotoToPersonalizeYourAccount = "choose_photo_to_personalize_your_account"
    case letPersonalizeYourLearning = "let_personalize_your_learning"
    case congrats = "congrats"
    case yourAccountHasBeenSuccessfullyCreated = "your_account_has_been_successfully_created"
    case startLearning = "start_learning"
    case educationStatus = "education_status"
    case  graduationYear = "graduation_year"
    case studyingField = "studying_field"
    
    //forget password
    case forgetYourPassword = "forget_your_password"
    case enterYourPhoneNumberToGetOTP = "enter_your_phone_number_to_get_o_t_p"
    case sendCodeViaTelegram = "send_code_via_telegram"
    case sendCodeViaSMS = "send_code_via_s_m_s"
    
    //reset password
    case resetYourPassword = "reset_your_password"
    case newPassword = "new_password"
    case submit = "submit"
    
    case yourPasswordHaveBeenChangedSuccessfully = "your_password_have_been_changed_successfully"
    
    //telegram
    case clickOnTelegramButton = "click_on_telegram_button"
    
    case startTheBot = "start_the_bot"
    
    case shareMobilePhone = "share_mobile_phone"
    
    case getTheVerificationCode = "get_the_verification_code"
    
    case openTelegram = "open_telegram"
}
