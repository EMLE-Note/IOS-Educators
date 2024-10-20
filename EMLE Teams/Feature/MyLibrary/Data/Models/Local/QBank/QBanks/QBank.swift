//
//  QBank.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import EMLECore

struct QBank: Hashable, Identifiable {
    let id = UUID()
    let qBankId: Int
    let uuid, name, overview: String
    let image: ImageUrl?
    let isVisible: Bool
    let price: Int?
    let duration: Int
    let trialDuration, questionsCount: Int
    let studentsCount: Int?
    let currency: String?

    
    init(qBankId: Int,
        uuid: String,
        name: String,
        overview: String,
        image: ImageUrl?,
        isVisible: Bool,
        price: Int?,
        duration: Int,
        trialDuration: Int,
        questionsCount: Int,
        studentsCount: Int?,
        currency: String?
    ) {
        self.qBankId = qBankId
        self.uuid = uuid
        self.name = name
        self.overview = overview
        self.image = image
        self.isVisible = isVisible
        self.price = price
        self.duration = duration
        self.trialDuration = trialDuration
        self.questionsCount = questionsCount
        self.studentsCount = studentsCount
        self.currency = currency
    }
    
    static func == (lhs: QBank, rhs: QBank) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension QBank {
    
    static let placeholder: QBank = {
        QBank(
            qBankId: 0,
            uuid: "",
            name: "QBank Name",
            overview: "",
            image: nil,
            isVisible: false,
            price: 0,
            duration: 0,
            trialDuration: 0,
            questionsCount: 0,
            studentsCount: 0,
            currency: ""
        )
    }()
}

extension [QBank] {
    
    static let placeholder: [QBank] = {
        var placeholder: [QBank] = []
        
        for i in 0..<5 {
            placeholder.append(QBank(
                qBankId: 0,
                uuid: "",
                name: "QBank Name",
                overview: "",
                image: nil,
                isVisible: false,
                price: 0,
                duration: 0,
                trialDuration: 0,
                questionsCount: 0,
                studentsCount: 0,
                currency: "")
            )
        }
        
        return placeholder
    }()
    
    static let libraryPlaceholder: [QBank] = {
        var placeholder: [QBank] = []
        
        for i in 0..<10 {
            
            var course = QBank(
                qBankId: 0,
                uuid: "",
                name: "QBank Name",
                overview: "",
                image: nil,
                isVisible: false,
                price: 0,
                duration: 0,
                trialDuration: 0,
                questionsCount: 0,
                studentsCount: 0,
                currency: ""
            )
            
            placeholder.append(course)
        }
        
        return placeholder
    }()
}
