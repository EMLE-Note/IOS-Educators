//
//  PermissionsView.swift
//  EMLE Teams
//
//  Created by iOSAYed on 07/09/2024.
//

import Foundation
import SwiftUI

struct PermissionsView: View {
    @State private var activeSection: String?
    @State private var selectedIds: Set<Int> = []

    let permissions: [String: [(id: Int, name: String)]]

    init(permissions: [String: [(id: Int, name: String)]]) {
        _activeSection = State(initialValue: permissions.keys.sorted().first)
        self.permissions = permissions
    }

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(permissions.keys.sorted(), id: \.self) { key in
                CollapsibleSection(
                    title: key.capitalized,
                    isActive: activeSection == key,
                    toggle: {
                        activeSection = activeSection == key ? nil : key
                    }
                ) {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(permissions[key]!, id: \.id) { permission in
                            HStack {
                                Button(action: {
                                    toggleSelection(for: permission.id)
                                }) {
                                    
                                    Image(systemName: selectedIds.contains(permission.id) ? "checkmark.square.fill" : "square")
                                        .foregroundColor(selectedIds.contains(permission.id) ? Color.primaryColor : .neutral)
                                }
                                Text(permission.name.capitalized) // Show, Create, Edit, Delete
                                    .font(.body)
                            }
                        }
                    }
                }
            }

            // Button to submit the selected IDs
            Button(action: {
                submitSelectedIds()
            }) {
                Text("Submit Selected IDs")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
        .padding()
    }
    
    // Function to toggle the selection of an ID
    private func toggleSelection(for id: Int) {
        if selectedIds.contains(id) {
            selectedIds.remove(id)
        } else {
            selectedIds.insert(id)
        }
    }
    
    // Function to handle submission of selected IDs
    private func submitSelectedIds() {
        // Here you can pass `selectedIds` to another endpoint
        print("Selected IDs: \(selectedIds)")
        
        // In a real app, you'd use a networking method (like URLSession or Alamofire) to submit `selectedIds`
    }
}
