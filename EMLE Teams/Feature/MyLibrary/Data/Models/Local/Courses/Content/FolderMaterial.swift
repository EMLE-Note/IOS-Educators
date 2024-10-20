//
//  FolderMaterial.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/08/2024.
//

import Foundation
import AVFoundation

// MARK: - Material

struct FolderMaterial: Identifiable, Equatable {
    
    let id: UUID = UUID()
    
    let materialId: Int
    let name: String
    let sort: Int
    let type: MaterialType
    let shouldPass: Bool
    let isFree: Bool
    
    let materialable: Materialable
    var isFinished: Bool = false
    
    var playerItem: AVPlayerItem?
    
    var link: String { materialable.link }
    var streamingLink: String { materialable.streamingLink }
    var emleLink: String { !streamingLink.isEmpty ? streamingLink : link }
        
    var questions: [Question] { materialable.questions }
    var duration: Int { materialable.duration }
    
    var hasTimedQuiz: Bool { materialable.duration > 0 }
    
    var pagesCount: Int { materialable.pagesCount }
    
    static func == (lhs: FolderMaterial, rhs: FolderMaterial) -> Bool {
        lhs.id == rhs.id
    }
}

extension FolderMaterial {
    
    static let placeholder: FolderMaterial = {
        FolderMaterial(materialId: 0,
                       name: "Material name",
                       sort: 0,
                       type: .video,
                       shouldPass: true,
                       isFree: false,
                       materialable: .placeholder)
    }()
    
    static let eBookPlaceholder: FolderMaterial = {
        
        let materialable = Materialable(id: 0,
                                        duration: 0,
                                        serverId: 0,
                                        size: 0,
                                        link: "https://api.printnode.com/static/test/pdf/multipage.pdf",
                                        streamingLink: "",
                                        uploadType: 1,
                                        pagesCount: 10,
                                        questions: [])
        
        let material = FolderMaterial(materialId: 0,
                                      name: "Book name",
                                      sort: 0,
                                      type: .eBook,
                                      shouldPass: true,
                                      isFree: false,
                                      materialable: materialable)
        
        return material
    }()
    
    static let quizPlaceholder: FolderMaterial = {
        
        let materialable = Materialable(id: 0,
                                        duration: 600,
                                        serverId: 0,
                                        size: 0,
                                        link: "",
                                        streamingLink: "",
                                        uploadType: 1,
                                        pagesCount: 0,
                                        questions: .placeholder)
        
        let material = FolderMaterial(materialId: 0,
                                      name: "Quiz name",
                                      sort: 0,
                                      type: .quiz,
                                      shouldPass: true,
                                      isFree: false,
                                      materialable: materialable)
        
        return material
    }()
}

extension [FolderMaterial] {
    
    static let placeholder: [FolderMaterial] = {
        var placeholder: [FolderMaterial] = []
        
        for i in 0..<5 {
            placeholder.append(FolderMaterial(materialId: i,
                                              name: "Material name \(i)",
                                              sort: i,
                                              type: MaterialType(rawValue: (i % 3) + 1)!,
                                              shouldPass: true,
                                              isFree: false,
                                              materialable: .placeholder))
        }
        
        return placeholder
    }()
    
    static let videosPlaceholder: [FolderMaterial] = {
        var placeholder: [FolderMaterial] = []
        
        let emleVideo = Materialable(id: 0,
                                     duration: 0,
                                     serverId: 0,
                                     size: 0,
                                     link: "https://dev.emleplayer.com/content/courses/videos/1Jq9nNt8y5AYTQPaYjANAlldukxyJu17iMUVxRwN.mp4",
                                     streamingLink: "",
                                     uploadType: 1,
                                     pagesCount: 0,
                                     questions: [])
        
        let emleMaterial = FolderMaterial(materialId: 1,
                                          name: "Emle video",
                                          sort: 1,
                                          type: .video,
                                          shouldPass: true,
                                          isFree: false,
                                          materialable: emleVideo)
        
        let driveVideo = Materialable(id: 0,
                                      duration: 0,
                                      serverId: 0,
                                      size: 0,
                                      link: "https://drive.google.com/file/d/1hCHKXXDl0tT0dz9g5qx0qQuZAOyILW8f/view?usp=drive_link",
                                      streamingLink: "",
                                      uploadType: 2,
                                      pagesCount: 0,
                                      questions: [])
        
        let driveMaterial = FolderMaterial(materialId: 2,
                                           name: "Drive video",
                                           sort: 2,
                                           type: .video,
                                           shouldPass: true,
                                           isFree: false,
                                           materialable: driveVideo)
        
        let youtubeVideo = Materialable(id: 0,
                                        duration: 0,
                                        serverId: 0,
                                        size: 0,
                                        link: "https://www.youtube.com/watch?v=PwXgg9adkdM",
                                        streamingLink: "",
                                        uploadType: 3,
                                        pagesCount: 0,
                                        questions: [])
        
        let youtubeMaterial = FolderMaterial(materialId: 3,
                                             name: "Youtube video",
                                             sort: 3,
                                             type: .video,
                                             shouldPass: true,
                                             isFree: false,
                                             materialable: youtubeVideo)
        
        placeholder.append(contentsOf: [emleMaterial, driveMaterial, youtubeMaterial])
        
        return placeholder
    }()
}

