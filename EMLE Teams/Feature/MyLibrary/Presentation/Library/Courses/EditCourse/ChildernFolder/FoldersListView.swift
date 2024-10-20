//
//  FoldersListView.swift
//  EMLE Learners
//
//  Created by Mustafa Merza on 5/2/24.
//

import SwiftUI
import EMLECore

struct FoldersListView: View {
    
    var folders: [Folder]
    var selectAction: FolderDelegate = nil
    var optianAction: FolderDelegate = nil
    var selectMaterialAction: FolderMaterialDelegate = nil
    
    var body: some View {
        list
    }
    
    private var list: some View {
        VStack(spacing: 16) {
            NoIndicatorsScrollView {
                ForEach(folders) { folder in
                    
                    getCell(for: folder)
                        .padding(.vertical, .xxSm)
                        .padding(.horizontal, .xxSm)
                }
            }
        }
    }
    
    @ViewBuilder
    private func getCell(for folder: Folder) -> some View {
        switch folder.type {
            
        case .parent :
            ParentFolderCell(folder: folder,
                             selectAction: selectAction,
                             optianAction: optianAction)
            
        case .lessons:
            
            ParentFolderCell(folder: folder,
                             selectAction: selectAction,
                             optianAction: optianAction)
        }
    }
}

#Preview {
    FoldersListView(folders: .placeholder)
}
