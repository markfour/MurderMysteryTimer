//
//  MainView.swift
//  swiftui-list
//
//  Created by Kazumi Hayashida on 2025/06/15.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ScenarioPhaseTimerListView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("タイマー")
                }
            
            ScenarioListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("ストーリー")
                }
            
            SimpleTimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("シンプル")
                }
        }
    }
}

#Preview {
    MainView()
}
