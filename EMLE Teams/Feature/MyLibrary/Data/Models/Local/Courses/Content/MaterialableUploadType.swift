//
//  MaterialableUploadType.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 24/08/2024.
//

import Foundation

enum MaterialableUploadType: Int {
    case emle = 1
    case youtube = 2
    case drive = 3
    
    var canBePlayedOnAVPlayer: Bool { self == .emle || self == .drive }
    var canBeDownloaded: Bool { self == .emle }
}
