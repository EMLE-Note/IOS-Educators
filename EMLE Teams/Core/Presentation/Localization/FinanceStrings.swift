//
//  FinanceStrings.swift
//  EMLE Teams
//
//  Created by iOSAYed on 18/07/2024.
//

import Foundation
import EMLECore

enum FinanceStrings: String,Localizable  {
    
    var tableName:String {
        return "FinanceStrings"
    }
    case externalWallet = "external_wallet"
    case paymentHistory = "payment_history"
    case confirmTransactions = "confirm_transactions"
    case transactions = "Transactions"
    case requests = "requests"
    case typeOfEnrollment = "type_of_enrollment "
    case materialName = "material_name"
    case MaterialType = "material_type"
    case paidAmount = "paid_amount"
    case automated = "automated"
    case request = "request"
    case manual = "manual"
    case transactionDetails = "transaction_details"
    case secretary = "secretary"
    case TransactionDate = "transaction_date"
    case phoneNumber = "Phone number"
    case name = "Name"
    case progress = "progress"
    case decline = "decline"
    case confirm = "Confirm"
    case pleaseConfirmReceiving = "please_confirm_receiving"
    case successfullyConfirmed = "successfully_confirmed"
    case noImageAttached = "no_image_attached"
    case enrollmentDetails = "enrollment_details"
    case enrollmentDetailsSmall = "enrollment_details_small"
    case declineDebit = "decline_debit"
    case deactivate = "Deactivate"
    case sendWarning = "send_warning"
    case resolve = "resolve"
    case addNewPaymentToDeclineDebits = "add_new_payment_to_decline_debits"
    case remindTheLearnerT0PayHisDebits = "remind_the_learner_to_pay_his_debits"
    case resolveAllTheLearnerDebits = "resolve_all_the_learner_debits"
    case disableTheLearnerAccessToTheCourse = "disable_the_learner_access_to_the_course"
    case enrollmentDebits = "enrollment_debits"
    case deactivateLearner = "deactivate_Learner"
    case deactivateDialogMessage = "deactivate_dialog_message"
    case yesDeactivate = "yes_deactivate"
    case resolveLearnerDebit = "resolve_learner_debit"
    case resolveDialogMessage = "resolve_dialog_message"
    case yesReslove = "yes_reslove"
    case noCancel = "no_cancel"
    case courses = "courses"
    case debitAmount = "debit_amount"
    case enrollmentType = "enrollment_type"
    case example = "example"
    case saveChanges = "save_changes"
    case noTransactionsYet = "No Transactions Yet"
    case noTransactionsMessage = "no_transactions_message"
    case noEnrollmentDebitsTitle = "no_enrollment_debits_title"
    case noEnrollmentDebitsMessage = "no_enrollment_debits_message"
    case noDataAppear = "no_data_appear"
}
