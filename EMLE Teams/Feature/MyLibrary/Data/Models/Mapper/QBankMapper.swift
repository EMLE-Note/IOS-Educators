//
//  QBankMapper.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 02/09/2024.
//

import Foundation
import EMLECore

extension QBankDTO {
    func toDomain() throws -> QBank {
        var imageUrl: ImageUrl? = nil
        
        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
                
        return QBank(qBankId: id, uuid: uuid, name: name, overview: overview, image: imageUrl, isVisible: is_visible, price: price, duration: duration ?? 0, trialDuration: trial_duration, questionsCount: questions_count, studentsCount: students_count, currency: currency)
    }
}

extension [QBankDTO] {
    func toDomain() throws -> [QBank] {
        try map { try $0.toDomain() }
    }
}

extension CurrencyBankDTO {
    func toDomain() throws -> CurrencyBank {
        CurrencyBank(id: id, name: name, code: code)
    }
}

extension GetQBankResponseDTO {
    func toDomain() throws -> QBankResponse {
        let qbanks = try qbanks.toDomain()
        return QBankResponse(qbanks: qbanks, pagination: pagination.toDomain(content: qbanks))
    }
}

extension GetQBank {
    func toRequest() -> GetQBankRequest {
        GetQBankRequest(filters: filters.toRequestDTO())
    }
}

extension GetQBankFilterRequest {
    func toRequestDTO() -> GetQBankFilterRequestDTO {
        GetQBankFilterRequestDTO(fieldId: fieldId, title: title, uuid: uuid, sort: sort)
    }
}

extension CreateQBank {
    func toRequest() -> CreateQBankRequest {
        return CreateQBankRequest(data: toRequestDTO())
    }
}

extension CreateQBank {
    func toRequestDTO() -> CreateQBankFromRequestDTO {
        return CreateQBankFromRequestDTO(name: name,
                                         uuid: uuid,
                                         image: image,
                                         price: price,
                                         duration: duration,
                                         is_visible: isVisible,
                                         overview: overview,
                                         reference_id: referenceId,
                                         trial_duration: trialDuration,
                                         questions: questions?.toRequest())
    }
}

extension [QuestionBankQuestionModel] {
    func toRequest() -> [QuestionBankQuestionFromRequestDTO] {
        map { $0.toRequestDTO() }
    }
}

extension QuestionBankQuestionModel {
    func toRequestDTO() -> QuestionBankQuestionFromRequestDTO {
        return QuestionBankQuestionFromRequestDTO(name: name, description: description, answers: answers.toRequest(), correct_answer: correct_answer, explanations: explanations, reference_syllabus_id: reference_syllabus_id, previous_exams: previous_exam_id, sources: source.toRequest())
    }
}

extension [Answer] {
    func toRequest() -> [AnswerFromRequestDTO] {
        map { $0.toRequestDTO() }
    }
}

extension Answer {
    func toRequestDTO() -> AnswerFromRequestDTO {
        return AnswerFromRequestDTO(name: name, explanation: explanation)
    }
}

extension Source {
    func toRequestDTO() -> SourceDTO {
        return SourceDTO(name: name, number: number)
    }
}

extension [Source] {
    func toRequest() -> [SourceDTO] {
        map { $0.toRequestDTO() }
    }
}

extension CreateQBankResponseDTO {
    func toDomain() throws -> CreateQBankResponse {
        var imageUrl: ImageUrl? = nil
        
        if let image {
            imageUrl = ImageUrl(urlString: image)
        }
        
        let questions = try questions.toDomain() 
        
        return CreateQBankResponse(id: id, uuid: uuid, name: name, overview: overview, image: imageUrl, isVisible: is_visible, price: price, duration: duration, trialDuration: trial_duration, questionsCount: questions_count, studentsCount: students_count, questions: questions)
    }
}

extension [QuestionBankDTO] {
    func toDomain() throws -> [QuestionBank] {
        try map { try $0.toDomain() }
    }
}

extension QuestionBankDTO {
    func toDomain() throws -> QuestionBank {
        
        let answers = try answers.toDomain()
        let previousExams = try previous_exams.toDomain()
        
        return QuestionBank(id: id, name: name, description: description, correctAnswer: correct_answer, sort: sort, answers: answers, previousExams: previousExams, referenceSyllabus: reference_syllabus.toDomain())
    }
}

extension [AnswerDTO] {
    func toDomain() throws -> [Answer] {
        try map { try $0.toDomain() }
    }
}

extension AnswerDTO {
    func toDomain() throws -> Answer {
        return Answer(name: name, explanation: explanation, isCorrect: isCorrect)
    }
}

extension [PreviousExamDTO] {
    func toDomain() throws -> [PreviousExam] {
        try map { try $0.toDomain() }
    }
}

extension PreviousExamDTO {
    func toDomain() -> PreviousExam {
        return PreviousExam(id: id, name: name)
    }
}

extension ReferenceSyllabusDTO {
    func toDomain() -> ReferenceSyllabus {
        return ReferenceSyllabus(referenceSyllabusId: id, name: name, overview: overview, examQuestionsPercentage: exam_questions_percentage, parentId: nil, children: [])
    }
}

extension GetQBankSettingParameter {
    func toRequest() -> GetSettingQBankRequest {
        return GetSettingQBankRequest(qbankId: qbankId, filters: filters.toRequestDTO())
    }
}

extension GetQBankSettingFilterRequest {
    func toRequestDTO() -> GetQBankSettingFilterRequestDTO {
        return GetQBankSettingFilterRequestDTO(fieldTitle: fieldTitle)
    }
}

extension UpdateQBankSettingParameter {
    func toRequest() -> UpdateQBankSettingRequest {
        return UpdateQBankSettingRequest(qbankId: qbankId, data: data.toRequest())
    }
}

extension UpdateQBankSettingFormDataRequest {
    func toRequest() -> UpdateQBankFormDataRequestDTO {
        return UpdateQBankFormDataRequestDTO(title: title, image: image, overview: overview, price: price, _method: method)
    }
}

extension UpdateQBankSettingResponseDTO {
    func toDomain() throws -> UpdateQBankSettingResponse {
        return UpdateQBankSettingResponse(id: id, uuid: uuid, name: name, overview: overview, image: image ?? "", isVisible: is_visible, price: price, duration: duration, trialDuration: trial_duration, questionsCount: questions_count, studentsCount: students_count)
    }
}
