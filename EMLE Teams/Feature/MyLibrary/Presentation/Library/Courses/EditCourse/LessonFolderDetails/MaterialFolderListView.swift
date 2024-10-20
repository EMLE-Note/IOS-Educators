//
//  MaterialFolderListView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 04/10/2024.
//

import SwiftUI
import EMLECore

struct MaterialFolderListView: View {
    
    var folders: [FolderMaterial]
    var selectAction: FoldersMaterialDelegate = nil
    var optianAction: FoldersMaterialDelegate = nil
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
    private func getCell(for folder: FolderMaterial) -> some View {
        
        MaterialFolderCell(folder: folder,
                         selectAction: selectAction,
                         optianAction: optianAction)
        
    }
}

#Preview {
    MaterialFolderListView(folders: .placeholder)
}
