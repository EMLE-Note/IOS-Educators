//
//  UploadMaterialType.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 05/10/2024.
//

import Foundation
import SwiftUI

enum UploadMaterialType: String, CaseIterable {
    case emleServer
    case otherProviders
    
    var localizedDescription: String {
        switch self {
        case .emleServer:
            return LibraryStrings.emleServer.localized
        case .otherProviders:
            return LibraryStrings.otherProviders.localized
        }
    }
}

enum VideoType: String, CaseIterable {
    case youtube
    case googleDrive
    case vimeo
    case publitio 
    
    var localizedDescription: String {
        switch self {
        case .youtube:
            return LibraryStrings.youtube.localized
        case .googleDrive:
            return LibraryStrings.googleDrive.localized
        case .vimeo:
            return LibraryStrings.vimeo.localized
        case .publitio:
            return LibraryStrings.publit.localized
        }
    }
    
    var icon: Image {
        switch self {
        case .youtube:
            return Image.youtubeIcon
        case .googleDrive:
            return Image.googleDrive
        case .vimeo:
            return Image.vimeoIcon
        case .publitio:
            return Image.publitIcon
        }
    }
    
    var uploadTypeValue: Int {
        switch self {
        case .youtube: return 2
        case .googleDrive: return 3
        case .vimeo: return 4
        case .publitio: return 5
        }
    } 
}
