//
//  Materialable.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/08/2024.
//

import Foundation

// MARK: - Materialable
struct Materialable {
    
    let id: Int // for videos
    let duration: Int // for videos, quizzes
    let serverId: Int // for videos
    
    let size: Int // for videos, e-books
    let link: String // for videos, e-books
    let streamingLink: String // for videos
    let uploadType: Int // for videos
    
    let pagesCount: Int // for e-books
    
    let questions: [Question] // for quizzes
}

extension Materialable {
    
    static let placeholder: Materialable = {
        Materialable(id: 1,
                     duration: 20,
                     serverId: 20,
                     size: 50,
                     link: "https://dev.emleplayer.com/content/courses/videos/IiOIQvpRSns3xJZLXQo5vHSMxDy791FNcqiXUEL4.mp4",
                     streamingLink: "",
                     uploadType: 1,
                     pagesCount: 1,
                     questions: [])
    }()
}
