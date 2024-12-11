//
//  ContentView.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 10/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var selection: Int = 0
    @Query var locations: [LocationModel]
    var isPreview = false
    
    var body: some View {
        TabView {
            MapView(listLocations: self.getLocations()).tabItem {
                Label("Map", systemImage: "map.fill")
            }
            
            ListView(locations: self.getLocations()).tabItem {
                Label("Liste", systemImage: "sharedwithyou")
            }
        }
    }
    
    func getLocations() -> [LocationModel] {
        return isPreview ? LocationModel.getLyonLocationsWithFullData() : locations
    }
}

#Preview {
    ContentView(isPreview: true)
}
