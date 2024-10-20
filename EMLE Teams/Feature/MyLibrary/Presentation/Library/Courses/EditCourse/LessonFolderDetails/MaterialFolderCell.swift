//
//  MaterialFolderCell.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 04/10/2024.
//

import Foundation
import EMLECore
import SwiftUI

struct MaterialFolderCell: View {
    
    var folder: FolderMaterial
    
    var selectAction: FoldersMaterialDelegate = nil
    var optianAction: FoldersMaterialDelegate = nil
    
    var body: some View {
        Button(action: {
            selectAction?(folder)
        }, label: {
            folderItem
                .withShimmerOverlay(cornerRadius: 8)
        })
    }
    
    private var folderItem: some View  {
        HStack(spacing: 8) {
            
            image
                .frame(width: 56)
            
            VStack(alignment: .leading, spacing: 4) {
                
                name
                
                size
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center, spacing: .xSm) {
                
                if folder.isFree { 
                    Text(LibraryStrings.free.localized)
                        .customStyle(.bodySmall, .container)
                        .padding(.horizontal, .xSm)
                        .padding(.vertical, .xxSm)
                        .customBackground(.success)
                        .customCornerRadii(.xSm, corners: .allCorners)
                }
                
                Image.optianCourse
                    .resizable()
                    .frame(width: 16, height: 16)
                    .onTapGesture {
                        optianAction?(folder)
                    }
                    
            }
            .padding(.xSm)
        }
        .padding(.all, 12)
        .customBackground(.container)
        .customBackground(.onPrimary)
        .withCardShadow(backgroundColor: .onSurface, cornerRadius: .sm)
        .padding(.horizontal, .xSm)
    }
    
    private var image: some View {
        Image.materialIcon
            .customCornerRadii(.xxSm, corners: .allCorners)
            .frame(width: 32, height: 32)
    }
    
    private var name: some View {
        Text(folder.name)
            .customStyle(.subheadline, .onSurface)
            .multilineTextAlignment(.leading)
    }
    
    private var size: some View {
        Text(formatBytes(folder.materialable.size))
            .customStyle(.caption2, .subtitle)
    }
    
    private func privacyView(isPublic: Bool) -> some View {
        Group {
            if !isPublic {
                Image.eyeOff
                    .resizable()
                    .frame(width: 30, height: 30)
            } else {
                EmptyView()
            }
        }
    }
    
    private func formatBytes(_ bytes: Int) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB, .useTB]
        formatter.countStyle = .file
        formatter.includesUnit = true
        return formatter.string(fromByteCount: Int64(bytes))
    }
}

#Preview {
    MaterialFolderCell(folder: .placeholder)
}
