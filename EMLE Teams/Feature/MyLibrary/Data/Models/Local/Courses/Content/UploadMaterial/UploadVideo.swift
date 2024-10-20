//
//  UploadMaterialRequestFrom.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 05/10/2024.
//

import Foundation

struct UploadVideo {
    let name: String
    let isVisible: Bool
    let shouldPass: Bool
    let isFree: Bool
    let courseFolderId: Int
    let file: Data? 
    let video: Video
}
