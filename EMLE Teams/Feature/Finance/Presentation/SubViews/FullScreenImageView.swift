//
//  FullScreenImageView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/08/2024.
//

import SwiftUI
import EMLECore

struct FullScreenImageView: View {
    @Binding var isShowingFullImage: Bool
    let imageUrl: ImageUrl

    var body: some View {
        ZStack {
            BlurView(style: .systemMaterialDark)
                               .edgesIgnoringSafeArea(.all)
            VStack {
                CustomImageView(image: imageUrl,contentMode: .fit)
               
            }
            .padding()
        }
        .onTapGesture {
            isShowingFullImage = false
        }
       
    }
}

#Preview {
    FullScreenImageView(isShowingFullImage: .constant(true), imageUrl: ImageUrl(urlString: ""))
}


