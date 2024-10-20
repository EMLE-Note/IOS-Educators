//
//  MyTeamsListView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 27/09/2024.
//

import EMLECore
import SwiftUI

struct MyTeamsListView: View {
    @Binding var teams: [Team]?
    @State var selectedTeamId: Int
    var onSelectionChanged: (Int) -> Void
    var onClickedOnCreateNewTeam: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: .md) {
            if let teams = teams {
                NoIndicatorsScrollView {
                    ForEach(teams) { team in
                        teamItem(team: team)
                    }
                }
            }

            createNewTeamItem
        }
    }

    private func teamItem(team: Team) -> some View {
        HStack(alignment: .center, spacing: .xSm) {
            Button(action: {
                print(team.teamId)
                onSelectionChanged(team.teamId)
                selectedTeamId = team.teamId
            }, label: {
                CustomImageView(image: team.image)
                    .clipShape(.circle)
                    .frame(width: 48, height: 48)

                Text(team.name)
                    .customStyle(.bodyMedium, .onSurface)

                Spacer()

                Image(systemName: selectedTeamId == team.teamId ? "checkmark.circle.fill" : "circle")
                    .frame(width: .xBig, height: .xBig)
                    .customForeground(selectedTeamId == team.teamId ? .primary : .clear)
            })
        }
    }

    private var createNewTeamItem: some View {
        HStack(alignment: .center, spacing: .xSm) {
            Image.plusCircleIcon
                .frame(width: 48, height: 48)

            Text("Create New Team")
                .customStyle(.bodyMedium, .onSurface)
        }
        .onTapGesture {
            onClickedOnCreateNewTeam()
        }
    }
}

#Preview {
    MyTeamsListView(teams: .constant(.placeholder),
                    selectedTeamId: 0,
                    onSelectionChanged: { _ in },
                    onClickedOnCreateNewTeam: {})
}
