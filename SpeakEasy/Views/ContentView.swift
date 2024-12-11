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
            MapView(listLocations: LocationModel.getLyonLocationsWithFullData()).tabItem {
                Label("Map", systemImage: "map.fill")
            }
            
            ListView(locations: LocationModel.getLyonLocationsWithFullData()).tabItem {
                Label("Contribute", systemImage: "sharedwithyou")
            }
        }
    }
}

#Preview {
    ContentView()
}
