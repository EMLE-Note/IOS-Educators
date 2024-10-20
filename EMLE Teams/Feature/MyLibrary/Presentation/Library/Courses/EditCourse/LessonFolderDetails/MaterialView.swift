//
//  MaterialView.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 04/10/2024.
//

import SwiftUI
import EMLECore

struct MaterialView: View {
        
    var materialFolder: [FolderMaterial]
    var optianAction: FoldersMaterialDelegate = nil
        
    var body: some View {
        VStack(spacing: 12) {
            
            foldersMaterialList
                .withShimmerOverlay()
        }
    }
    
    private var foldersMaterialList: some View {
        MaterialFolderListView(folders: materialFolder,
                               optianAction: optianAction)
    }
}

#Preview {
    MaterialFolderListView(folders: .placeholder)
}
