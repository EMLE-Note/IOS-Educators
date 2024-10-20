//
//  ExcelQuestion.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 09/09/2024.
//

import Foundation
import CoreXLSX
import EMLECore

extension QuestionBankQuestionModel {
    static var placeHolder: QuestionBankQuestionModel {
        return QuestionBankQuestionModel(id: 0, name: "Placeholder Question", description: "", answers: [], correct_answer: "", explanations: [], reference_syllabus_id: 0, previous_exam_id: [], source: [])
    }
}


enum ExcelReaderError: Error, CustomStringConvertible {
    case failedToOpenFile
    case failedToParseWorkbooks
    case failedToParseSharedStrings
    case failedToParseWorksheet
    case missingQuestion(rowIndex: Int)
    case missingFirstAnswer(rowIndex: Int)
    case invalidCorrectAnswerIndex(rowIndex: Int, providedIndex: String)

    var description: String {
        switch self {
        case .failedToOpenFile:
            return "Failed to open the Excel file."
        case .failedToParseWorkbooks:
            return "Failed to parse the workbooks in the Excel file."
        case .failedToParseSharedStrings:
            return "Failed to parse shared strings in the Excel file."
        case .failedToParseWorksheet:
            return "Failed to parse the worksheet."
        case .missingQuestion(let rowIndex):
            return "Missing question text at row \(rowIndex)."
        case .missingFirstAnswer(let rowIndex):
            return "Missing first answer at row \(rowIndex)."
        case .invalidCorrectAnswerIndex(let rowIndex, let providedIndex):
            return "Invalid correct answer index '\(providedIndex)' at row \(rowIndex)."
        }
    }
}


class ExcelReader {
    func readExcelFile(at url: URL) throws -> ExcelQuestionBankResult {
        guard let file = XLSXFile(filepath: url.path) else {
            throw ExcelReaderError.failedToOpenFile
        }

        guard let sharedStrings = try? file.parseSharedStrings() else {
            throw ExcelReaderError.failedToParseSharedStrings
        }

        var excelRows = [QuestionBankQuestionModel]()
        for wbk in try file.parseWorkbooks() {
            for (_, path) in try file.parseWorksheetPathsAndNames(workbook: wbk) {
                let worksheet = try file.parseWorksheet(at: path)
                var rowIndex = 1  // Assuming the first row is headers
                for row in worksheet.data?.rows.dropFirst() ?? [] {
                    rowIndex += 1
                    let cells = row.cells.map { $0.stringValue(sharedStrings) ?? "" }

                    guard let firstCell = cells.first, !firstCell.isEmpty else {
                        print("Empty first cell (question) encountered at row \(rowIndex), stopping further processing of this worksheet.")
                        break  // Stop processing this worksheet further
                    }

                    // Explanations extracted with the correct mapping, ensuring all indices are accounted for.
                    let explanations = (8...12).map { index -> String in
                        cells.indices.contains(index) ? cells[index] : ""
                    }

                    var answers: [Answer] = []
                    let correctAnswerIndexStr = cells.indices.contains(7) ? cells[7] : "-1"
                    let correctAnswerIndex = Int(correctAnswerIndexStr) ?? -1
                    let zeroBasedCorrectIndex = correctAnswerIndex - 1

                    if let firstAnswer = cells.indices.contains(2) ? cells[2] : nil, !firstAnswer.isEmpty {
                        for i in 0...3 {
                            let answerIndex = 2 + i
                            if cells.indices.contains(answerIndex) && !cells[answerIndex].isEmpty {
                                let explanationIndex = 12 + i
                                let explanation = cells.indices.contains(explanationIndex) ? cells[explanationIndex] : ""
                                let isCorrect = i == zeroBasedCorrectIndex
                                answers.append(Answer(
                                    name: cells[answerIndex],
                                    explanation: explanation,
                                    isCorrect: isCorrect,
                                    state: isCorrect ? AnswerState.correct : AnswerState.idle
                                ))
                            }
                        }
                    } else {
                        throw ExcelReaderError.missingFirstAnswer(rowIndex: rowIndex)
                    }

                    let questionModel = QuestionBankQuestionModel(
                        id: rowIndex,
                        name: firstCell,
                        description: cells.indices.contains(1) ? cells[1] : "",
                        answers: answers,
                        correct_answer: correctAnswerIndexStr,
                        explanations: explanations,
                        reference_syllabus_id: Int(cells.indices.contains(13) ? cells[13] : "0") ?? 0,
                        reference_syllabus: nil,
                        previous_exam_id: cells.indices.contains(14) ? [Int(cells[14]) ?? 0] : [0],
                        source: [Source( 
                            name: cells.indices.contains(15) ? cells[15] : "",
                            number: Int(cells.indices.contains(16) ? cells[16] : "0") ?? 0
                        )]
                    )
                    excelRows.append(questionModel)
                    
                    print(questionModel)
                }
            }
        }

        return ExcelQuestionBankResult(msg: "", fileName: url.lastPathComponent, list: excelRows)
    }
}


// Safely access an array element by index
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
