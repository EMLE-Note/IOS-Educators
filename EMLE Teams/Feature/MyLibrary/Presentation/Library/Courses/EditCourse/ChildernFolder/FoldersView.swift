//
//  FoldersView.swift
//  EMLE Learners
//
//  Created by Mustafa Merza on 5/2/24.
//

import SwiftUI
import EMLECore

struct FoldersView: View {
    
    var parentFolder: Folder?
    var backAction: EmptyAction = nil
    var editAction: EmptyAction = nil
    
    var folders: [Folder]
    var selectAction: FolderDelegate = nil
    var optianAction: FolderDelegate = nil
    
    var selectMaterialAction: FolderMaterialDelegate = nil
    
    var body: some View {
        VStack(spacing: 12) {
            
            if parentFolder != nil {
                
                folderTitle
                    .unredacted()
            }
            
            foldersList
                .withShimmerOverlay()
        }
    }
    
    private var folderTitle: some View {
        HStack {
            Button(action: {
                backAction?()
            }, label: {
                
                HStack(spacing: 8) {
                    
                    Image.chevronBackward
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .customForeground(.subtitle)
                    
                    Text((parentFolder?.parent == nil ? parentFolder?.name : parentFolder?.parent?.name) ?? "")
                        .customStyle(.subheadline, .onSurface)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(.bottom, .xSm)
                .padding(.horizontal, defaultHPadding)
            })
            
            Spacer()
            
            Image.edit
                .resizable()
                .frame(width: 28, height: 28)
                .padding(.bottom, .xSm)
                .padding(.horizontal, .md)
                .onTapGesture {
                    editAction?()
                }
            
        }
        .customBackground(.container)
    }
    
    private var foldersList: some View {
        FoldersListView(folders: folders,
                        selectAction: selectAction,
                        optianAction: optianAction,
                        selectMaterialAction: selectMaterialAction)
    }
}

#Preview {
    FoldersView(folders: .placeholder)
}
