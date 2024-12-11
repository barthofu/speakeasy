//
//  ContributeView.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 10/12/2024.
//

import SwiftUI

struct ListView: View {
    var locations: [LocationModel] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(locations) { location in
                    NavigationLink {
                        DetailView(location: location)
                    } label: {
                        LocationListItem(location: location)
                    }
                }
            }.overlay(Group {
                if locations.isEmpty {
                    Text("No locations")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            })
            .animation(.default, value: locations)
            .navigationTitle("Locations")
            .toolbar {
                NavigationLink {
                    AddLocationView()
                } label: {
                    Image(systemName: "plus")
                }
                .padding()
            }
        }
    }
}

#Preview {
    ListView(locations: LocationModel.getLyonLocationsWithFullData())
}
