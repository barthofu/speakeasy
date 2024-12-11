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
                MapView(listLocations: Location.getLyonLocationsWithFullData()).tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                
                ListView().tabItem {
                    Label("Contribute", systemImage: "sharedwithyou")
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
