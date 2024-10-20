//
//  UploadVideoResponse.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 06/10/2024.
//

import Foundation

// MARK: - UploadVideoResponse
struct UploadVideoResponse {
    let id: Int?
    let name: String?
    let sort, type: Int?
    let shouldPass, isFree, isVisible: Bool?
    let materialable: Materialable?
}
