//
//  CustomNavigationBar.swift
//  EMLE Teams
//
//  Created by iOSAYed on 08/06/2024.
//

import SwiftUI
import EMLECore

struct CustomNavigationBar: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let style: CustomNavigationBarStyle
    private let title: String
    
    private let backAction: EmptyAction
    private let shareAction: EmptyAction
    private let notificationAction: EmptyAction
    private let settingAction: EmptyAction
    private let editAction: EmptyAction
    
    
    
    private init(style: CustomNavigationBarStyle,
                 title: String = "",
                 backAction: EmptyAction = nil,
                 shareAction: EmptyAction = nil,
                 notificationAction: EmptyAction = nil,
                 settingAction: EmptyAction = nil,
                 editAction: EmptyAction = nil) {
        self.style = style
        self.title = title
        self.backAction = backAction
        self.shareAction = shareAction
        self.notificationAction = notificationAction
        self.settingAction = settingAction
        self.editAction = settingAction
    }
    
    var body: some View {
        switch style {
        case .exploreCourse:
            exploreCourseNavigationBar
            
        case .exploreEBook:
            exploreEBookNavigationBar
            
        case .exploreQuiz:
            exploreQuizNavigationBar
            
        case .filters:
            filtersNavigationBar
            
        case .ownerProfile:
            ownerProfileNavigationBar
            
        case .checkout:
            checkoutNavigationBar
            
        case .sampleQuestions:
            sampleQuestionsNavigationBar
        case .dashboard:
            dashboardNavigationBar(isHasTeamImage: false)
        case .navBarWithTrailingButton:
            navBarWithTrailingButton
        }
    }
}

extension CustomNavigationBar {
    
    static func ExploreCourse(backAction: EmptyAction = nil,
                                           shareAction: EmptyAction) -> some View {
        CustomNavigationBar(style: .exploreCourse,
                            backAction: backAction,
                            shareAction: shareAction)
    }
    
    static func ExploreEBook(backAction: EmptyAction = nil,
                                          shareAction: EmptyAction) -> some View {
        CustomNavigationBar(style: .exploreEBook,
                            backAction: backAction,
                            shareAction: shareAction)
    }
    
    static func ExploreQuiz(backAction: EmptyAction = nil,
                                         shareAction: EmptyAction) -> some View {
        CustomNavigationBar(style: .exploreQuiz,
                            backAction: backAction,
                            shareAction: shareAction)
    }
    
    static func Filters(title: String,
                        backAction: EmptyAction = nil) -> some View {
        CustomNavigationBar(style: .filters,
                            title: title,
                            backAction: backAction)
    }
    
    static func OwnerProfile(title: String) -> some View {
        CustomNavigationBar(style: .ownerProfile,
                            title: title)
    }
    
    static func Checkout(title: String,
                         backAction: EmptyAction = nil) -> some View {
        CustomNavigationBar(style: .checkout,
                            title: title,
                            backAction: backAction)
    }
    
    static func SampleQuestions(title: String) -> some View {
        CustomNavigationBar(style: .sampleQuestions,
                            title: title)
    }
    
    static func dashboard(title: String,notificationAction:EmptyAction,settingAction:EmptyAction) -> some View {
        CustomNavigationBar(style:.dashboard,title: title, notificationAction: notificationAction,settingAction: settingAction)
    }
    
    static func navBarWithTrailingButton(title: String,editAction:EmptyAction) -> some View {
        CustomNavigationBar(style:.navBarWithTrailingButton,title: title, editAction: editAction)
    }
}

extension CustomNavigationBar {
    
    private var exploreCourseNavigationBar: some View {
        HStack {
            RoundImageButton(image: .xMark, action: back, buttonSize: CGSize(width: 8, height: 14))
            Spacer()
            
            RoundImageButton(image: .share,
                             action: shareAction,
                             buttonSize: CGSize(width: 16, height: 14))
        }
    }
    
    private var exploreEBookNavigationBar: some View {
        HStack {
            RoundImageButton(image: .chevronBackward,
                             action: back,
                             buttonSize: CGSize(width: 8, height: 14))
            
            Spacer()
            
            RoundImageButton(image: .share,
                             action: shareAction,
                             buttonSize: CGSize(width: 16, height: 14))
        }
    }
    
    private var exploreQuizNavigationBar: some View {
        exploreEBookNavigationBar
    }
    
    private var filtersNavigationBar: some View {
        ownerProfileNavigationBar
    }
    
    private func back() {
        if let backAction {
            backAction()
        }
        else {
            dismiss()
        }
    }
}

extension CustomNavigationBar {
    
    private var ownerProfileNavigationBar: some View {
        HStack(spacing: 8) {
            
            BackButton(action: back)
            
            navigationTitle
            
            Spacer()
        }
    }
    
    private var checkoutNavigationBar: some View {
        ownerProfileNavigationBar
    }
    
    private var navigationTitle: some View {
        Text(title)
            .customStyle(.subheadline, .onSurface)
    }
}

extension CustomNavigationBar {
    
    private var sampleQuestionsNavigationBar: some View {
        HStack {
            
            BackButton(action: back)
            
            Spacer()
        }
        .overlay {
            
            Text(title)
                .customStyle(.headline, .onSurface)
        }
    }
}

extension CustomNavigationBar {
    private func dashboardNavigationBar(isHasTeamImage:Bool) -> some View {
        HStack {
           if isHasTeamImage {
               
               Text(title)
                   .customStyle(.subheadline, .onSurface)
               Spacer()
           }else {
               Text(title)
                   .customStyle(.subheadline, .onSurface)
               Spacer()
           }
            HStack {
                Button {
                    notificationAction?()
                } label: {
                    Image.notificationIcon
                        .frame(width: 16, height: 14)
                }
                
                Button {
                    settingAction?()
                } label: {
                    Image.settingIcon
                        .frame(width: 16, height: 14)
                }

//                RoundImageButton(image: .notificationIcon,
//                                 action: notificationAction,
//                                 buttonSize: CGSize(width: 8, height: 14))
//                RoundImageButton(image: .settingIcon,
//                                 action: settingAction,
//                                 buttonSize: CGSize(width: 16, height: 14))
            }
        }
    }
}

extension CustomNavigationBar {
    private var navBarWithTrailingButton: some View {
        HStack(spacing: 8) {
            
            BackButton()
            navigationTitle
            Spacer()
            Button(action: {editAction?()}, label: {
                Image.edit
                    .resizable()
                    .frame(width: 22, height: 22)
            })
        }
    }
}

#Preview {
    CustomNavigationBar.dashboard(title: "Dashboard", notificationAction: nil, settingAction: nil)
}
