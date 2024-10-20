//
//  CollapsibleSectionsViewModel.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 13/08/2024.
//

import SwiftUI

enum ActiveSection {
    case none, publishNow, schedule
}

class CollapsibleSectionsViewModel: ObservableObject {
    @Published var activeSection: ActiveSection = .none
    
    func toggleSection(_ section: ActiveSection) {
        if activeSection == section {
            activeSection = .none
        } else {
            activeSection = section
        }
    }
    
    func isActive(_ section: ActiveSection) -> Bool {
        return activeSection == section
    }
}
