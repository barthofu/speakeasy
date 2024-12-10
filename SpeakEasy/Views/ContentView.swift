//
//  ContentView.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 10/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 0
    
    var body: some View {
            TabView {
                MapView().tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                
                ContributeView().tabItem {
                    Label("Contribute", systemImage: "sharedwithyou")
                }
                
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
