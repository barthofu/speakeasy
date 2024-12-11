//
//  ContributeView.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 10/12/2024.
//

import SwiftUI

struct ListView: View {
    @State var selectedFilter: LocationType?
    
    var locations: [LocationModel] = []
    
    var filteredLocations: [LocationModel] {
        if(locations.isEmpty || selectedFilter == nil) {
            return locations
        }
        
        return locations.filter { location in
            location.type == selectedFilter
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Picker(selection: $selectedFilter, label: Text("Filter")) {
                    Text("All").tag(nil as LocationType?)
                    ForEach(LocationType.allCases) { type in
                        Text(LocalizedStringKey(type.displayName)).tag(type)
                    }
                }
                ForEach(filteredLocations) { location in
                    NavigationLink {
                        DetailView(location: location)
                    } label: {
                        LocationListItem(location: location)
                    }
                }
            }.overlay(Group {
                if filteredLocations.isEmpty {
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
