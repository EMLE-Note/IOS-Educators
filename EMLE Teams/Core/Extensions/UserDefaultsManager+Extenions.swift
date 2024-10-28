//
//  UserDefaultsManager+Extenions.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 27/10/2024.
//

import Foundation
import EMLECore

enum UserDefaultsKeys: String {
    case materialId = "com.emle.materialId.user"
}

struct UserDefaultsManage {
    
    private let userDefaults = UserDefaults.standard
    
    func setMaterialId(_ id: Int) {
        userDefaults.set(id, forKey: UserDefaultsKeys.materialId.rawValue)
    }
    
    func getMaterialId() -> Int? {
        let id = userDefaults.integer(forKey: UserDefaultsKeys.materialId.rawValue)
        return id != 0 ? id : nil 
    }
    
    func removeMaterialId() {
        userDefaults.removeObject(forKey: UserDefaultsKeys.materialId.rawValue)
    }
}


