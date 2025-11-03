//
//  StoryListView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/11/04.
//

import SwiftUI

struct StoryListView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Text("ストーリー1")
                Text("ストーリー2")
                Text("ストーリー3")
            }
            .navigationTitle("ストーリー一覧")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("閉じる") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    StoryListView()
}