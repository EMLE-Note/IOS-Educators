//
//  ParentFolderCell.swift
//  EMLE Learners
//
//  Created by Mustafa Merza on 5/2/24.
//

import SwiftUI
import EMLECore

struct ParentFolderCell: View {
    
    var folder: Folder
    
    var selectAction: FolderDelegate = nil
    var optianAction: FolderDelegate = nil
    
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
                
                numbers
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center, spacing: .xSm) {
                privacyView(isPublic: folder.isVisible)
                
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
        Image.folderIcon
            .customCornerRadii(.xxSm, corners: .allCorners)
            .frame(width: 57, height: 57)
    }
    
    private var name: some View {
        Text(folder.name)
            .customStyle(.subheadline, .onSurface)
            .multilineTextAlignment(.leading)
    }
    
    private var numbers: some View {
        Text(numbersString)
            .customStyle(.caption2, .subtitle)
    }
    
    private var numbersString: String {
        "".appendingFormat("%@ . %@ . %@",
                           LibraryStrings.DBook.localizedPlural(argument: folder.booksCount),
                           LibraryStrings.DQuiz.localizedPlural(argument: folder.quizCount),
                                                                folder.videosDurationString)
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
}

#Preview {
    ParentFolderCell(folder: .placeholder)
}
