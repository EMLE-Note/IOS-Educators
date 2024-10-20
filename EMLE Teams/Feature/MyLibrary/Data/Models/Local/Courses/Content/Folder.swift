//
//  Folder.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 17/08/2024.
//

import Foundation
// MARK: - Folder
struct Folder: Identifiable {
    
    let id: UUID = UUID()
    
    let folderId: Int
    let name: String
    let sort: Int
    let type: FolderType
    let level: FolderLevel
    let videosDuration: Int
    let videosDurationString: String
    let booksCount: Int
    let quizCount: Int
    let isVisible: Bool
    let foldersCount: Int
    
    var children: [Folder]
    
    var materials: [FolderMaterial]
    
    var parent: ParentFolder?
    
    var parentId: Int?
    
    init(folderId: Int,
         name: String,
         sort: Int,
         type: FolderType,
         level: FolderLevel,
         videosDuration: Int,
         booksCount: Int,
         quizCount: Int,
         isVisible: Bool,
         foldersCount: Int,
         children: [Folder],
         materials: [FolderMaterial],
         parent: ParentFolder?,
         parentId: Int?) {
        self.folderId = folderId
        self.name = name
        self.sort = sort
        self.type = type
        self.level = level
        self.videosDuration = videosDuration
        self.booksCount = booksCount
        self.quizCount = quizCount
        self.isVisible = isVisible
        self.foldersCount = foldersCount
        self.children = children
        self.materials = materials
        self.parent = parent
        self.parentId = parentId
        self.videosDurationString = Date.getVideosDurationString(from: videosDuration)
    }
}

extension Folder {
    
    static let placeholder: Folder = {
        Folder(folderId: 0,
               name: "Folder",
               sort: 1,
               type: .parent,
               level: .first,
               videosDuration: 40,
               booksCount: 10,
               quizCount: 10,
               isVisible: false,
               foldersCount: 0,
               children: [],
               materials: [],
               parent: .placeholder,
               parentId: nil)
    }()
}

extension [Folder] {
    
    static let placeholder: [Folder] = {
        var placeholder: [Folder] = []
        
        for i in 0..<5 {
            placeholder.append(Folder(folderId: 0,
                                      name: "Folder",
                                      sort: i,
                                      type: .parent,
                                      level: .first,
                                      videosDuration: 40,
                                      booksCount: 10,
                                      quizCount: 10,
                                      isVisible: false,
                                      foldersCount: 0,
                                      children: [],
                                      materials: [],
                                      parent: .placeholder,
                                      parentId: nil))
        }
        
        return placeholder
    }()
    
    static let placeholderWithChildren: [Folder] = {
        var placeholder: [Folder] = []
        
        for i in 0..<5 {
            placeholder.append(Folder(folderId: i,
                                      name: "First Folder \(i)",
                                      sort: i,
                                      type: .parent,
                                      level: .first,
                                      videosDuration: 40,
                                      booksCount: 10,
                                      quizCount: 10,
                                      isVisible: false,
                                      foldersCount: 0,
                                      children: .children1,
                                      materials: [],
                                      parent: .placeholder,
                                      parentId: nil))
        }
        
        return placeholder
    }()
    
    static let children1: [Folder] = {
        var placeholder: [Folder] = []
        
        for i in 5..<10 {
            placeholder.append(Folder(folderId: i,
                                      name: "Second Folder \(i)",
                                      sort: i,
                                      type: .parent,
                                      level: .second,
                                      videosDuration: 40,
                                      booksCount: 10,
                                      quizCount: 10,
                                      isVisible: false,
                                      foldersCount: 0,
                                      children: children2,
                                      materials: [],
                                      parent: .placeholder,
                                      parentId: 0))
        }
        
        return placeholder
    }()
    
    static let children2: [Folder] = {
        var placeholder: [Folder] = []
        
        for i in 10..<15 {
            placeholder.append(Folder(folderId: i,
                                      name: "Third Folder \(i)",
                                      sort: i,
                                      type: .lessons,
                                      level: .third,
                                      videosDuration: 40,
                                      booksCount: 10,
                                      quizCount: 10,
                                      isVisible: false,
                                      foldersCount: 0,
                                      children: [],
                                      materials: .placeholder,
                                      parent: .placeholder,
                                      parentId: 5))
        }
        
        return placeholder
    }()
}

