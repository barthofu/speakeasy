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
            TabView(selection: $selection) {
                Tab("Nearby", systemImage: "map.fill", value: 0) {
                    MapView()
                }


                Tab("Contribute", systemImage: "sharedwithyou", value: 1) {
                    MapView()
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
