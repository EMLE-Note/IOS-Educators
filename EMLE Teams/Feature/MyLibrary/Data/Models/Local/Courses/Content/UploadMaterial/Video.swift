//
//  VideoRequestFrom.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 05/10/2024.
//

import Foundation

enum UploadType: Int, Codable {
    case device = 1
    case youtube = 2
    case googleDrive = 3
    case vimeo = 4
}

struct Video {
    let duration: Int
    let size: Int
    let serverId: Int 
    let uploadType: Int
    let link: String?
}

