//
//  sac.swift
//  EMLE Teams
//
//  Created by iOSAYed on 16/08/2024.
//

import Foundation
import EMLECore

struct Course: Hashable, Identifiable {
    let id = UUID()
    let courseId: Int
    let uuid, name, overview: String
    let image: ImageUrl?
    let status: Int
    let duration: Int
    let price: Double
    let currency: String
    let publishAt: String
    let studentsCount: Int
    let videosDuration: Int
    let videosDurationString: String
    let booksCount: Int
    let quizCount: Int
    let foldersCount: Int
    let targets: [Target]?
    var team: Team
    
    let folders: [Folder]
    
    let rating: Double = 4.5
    
    let security: Security
    
    /// Library
    var isAllowedOffline: Bool = false
    
    let groups: [GroupCourse]?
    
    init(courseId: Int,
         uuid: String,
         name: String,
         overview: String,
         image: ImageUrl?,
         status: Int,
         duration: Int,
         price: Double,
         currency: String,
         publishAt: String,
         studentsCount: Int,
         videosDuration: Int,
         booksCount: Int,
         quizCount: Int,
         foldersCount: Int,
         targets: [Target]?,
         team: Team,
         folders: [Folder],
         security: Security,
         isAllowedOffline: Bool,
         groups: [GroupCourse]?
    ) {
        self.courseId = courseId
        self.uuid = uuid
        self.name = name
        self.overview = overview
        self.image = image
        self.status = status
        self.duration = duration
        self.price = price
        self.currency = currency
        self.publishAt = publishAt
        self.studentsCount = studentsCount
        self.videosDuration = videosDuration
        self.booksCount = booksCount
        self.quizCount = quizCount
        self.foldersCount = foldersCount
        self.targets = targets
        self.team = team
        self.folders = folders
        self.security = security
        self.isAllowedOffline = isAllowedOffline
        self.videosDurationString = Date.getVideosDurationString(from: videosDuration)
        self.groups = groups
    }
    
    static func == (lhs: Course, rhs: Course) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Course {
    
    static let placeholder: Course = {
        Course(courseId: 0,
               uuid: "",
               name: "Course name",
               overview: "Course overvierw",
               image: .placeholder,
               status: 1,
               duration: 100,
               price: 200,
               currency: "EGP",
               publishAt: "",
               studentsCount: 15,
               videosDuration: 3000,
               booksCount: 15,
               quizCount: 15,
               foldersCount: 0,
               targets: [],
               team: .placeholder,
               folders: .placeholder,
               security: .placeholder,
               isAllowedOffline: false,
               groups: [])
    }()
}

extension [Course] {
    
    static let placeholder: [Course] = {
        var placeholder: [Course] = []
        
        for i in 0..<5 {
            placeholder.append(Course(courseId: 0,
                                      uuid: "",
                                      name: "Course name",
                                      overview: "Course overvierw",
                                      image: .placeholder,
                                      status: 1,
                                      duration: 100,
                                      price: 200,
                                      currency: "EGP",
                                      publishAt: "",
                                      studentsCount: 15,
                                      videosDuration: 3000,
                                      booksCount: 15,
                                      quizCount: 15,
                                      foldersCount: 0,
                                      targets: [],
                                      team: .placeholder,
                                      folders: .placeholder,
                                      security: .placeholder,
                                      isAllowedOffline: false,
                                      groups: [])
                               )
        }
        
        return placeholder
    }()
    
    static let libraryPlaceholder: [Course] = {
        var placeholder: [Course] = []
        
        for i in 0..<10 {
            
            var course = Course(courseId: 0,
                                uuid: "",
                                name: "Course name",
                                overview: "Course overvierw",
                                image: .placeholder,
                                status: 1,
                                duration: 100,
                                price: 200,
                                currency: "EGP",
                                publishAt: "",
                                studentsCount: 15,
                                videosDuration: 3000,
                                booksCount: 15,
                                quizCount: 15,
                                foldersCount: 0,
                                targets: [],
                                team: .placeholder,
                                folders: .placeholder,
                                security: .placeholder,
                                isAllowedOffline: false,
                                groups: [])
            
            
            placeholder.append(course)
        }
        
        return placeholder
    }()
}
