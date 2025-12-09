//
//  ContentView.swift
//  MurderMysteryTimer
//
//  Created by Kazumi Hayashida on 2025/12/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("タイマー")
                }
            
            ScenarioListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("シナリオ")
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
    ContentView()
}
