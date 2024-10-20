//
//  TelegramView.swift
//  EMLE Learners
//
//  Created by Abdelrhman Sultan on 02/06/2024.
//

import SwiftUI
import EMLECore

struct TelegramView: View {
    
    var action: EmptyAction = nil
    
    var body: some View {
        VStack(spacing: 24) {
            image
            
            continueWithTelegram
            
            VStack(alignment: .leading, spacing: 8) {
                clickOnTelegramButton
                
                startTheBot
                
                shareMobilePhone
                
                getTheVerificationCode
            }
            
            openTelegram
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .customBackground(.container)
        .customCornerRadii(12, corners: .allCorners)
        .padding(.horizontal, 32)
        .handleLayoutChanges()
    }
    
    private var image: some View {
        Image.send
            .resizable()
            .frame(width: 40, height: 40)
            .customForeground(.primary)
            .padding(32)
            .customBackground(.surface)
            .customCornerRadii(12, corners: .allCorners)
    }
    
    private var continueWithTelegram: some View {
        Text(RegistrationStrings.continueWithTelegram.localized)
            .customStyle(.heading2, .subtitle)
    }
    
    private var clickOnTelegramButton: some View {
        Text(RegistrationStrings.clickOnTelegramButton.localized)
            .customStyle(.bodySmall, .subtitle)
    }
    
    private var startTheBot: some View {
        Text(RegistrationStrings.startTheBot.localized)
            .customStyle(.bodySmall, .subtitle)
    }
    
    private var shareMobilePhone: some View {
        Text(RegistrationStrings.shareMobilePhone.localized)
            .customStyle(.bodySmall, .subtitle)
    }
    
    private var getTheVerificationCode: some View {
        Text(RegistrationStrings.getTheVerificationCode.localized)
            .customStyle(.bodySmall, .subtitle)
    }
    
    private var openTelegram: some View {
        PrimaryButton(title: RegistrationStrings.openTelegram.localized,
                      action: action)
    }
}

#Preview {
    TelegramView()
}
