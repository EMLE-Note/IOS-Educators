//
//  GroupCourse.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 21/08/2024.
//

import Foundation
import EMLECore

// MARK: - Group
struct GroupCourse: Hashable, CustomPickerItem, Identifiable {
    var id = UUID()
    let groupId: Int
    let name: String
    let courses: [Course]?
    
    var displayName: String {
        return name
    }
    
    init(groupId: Int, name: String, courses: [Course]?) {
        self.groupId = groupId
        self.name = name
        self.courses = courses
    }
    
    static func == (lhs: GroupCourse, rhs: GroupCourse) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension GroupCourse {
    
    static let placeholder: GroupCourse = {
        GroupCourse(groupId: -1, name: "iOS", courses: [])
    }()
}

extension [GroupCourse] {
    
    static let placeholder: [GroupCourse] = {
        var placeholder: [GroupCourse] = []
        
        for i in 0..<5 {
            placeholder.append(GroupCourse(groupId: 0, name: "iOS", courses: []))
        }
        
        return placeholder
    }()
    
    static let groupPlaceholder: [GroupCourse] = {
        var placeholder: [GroupCourse] = []
        
        for i in 0..<10 {
            
            var groupCourse = GroupCourse(groupId: 0, name: "iOS", courses: [])
            
            placeholder.append(groupCourse)
        }
        
        return placeholder
    }()
}
