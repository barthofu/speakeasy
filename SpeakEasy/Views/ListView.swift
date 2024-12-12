//
//  ContributeView.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 10/12/2024.
//

import SwiftUI

struct ListView: View {
    @Environment(\.modelContext) var modelContext
    
    @State var selectedFilter: LocationType?
    @State private var isPresented = false
    @State private var addLocationModalPresented = false
    
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
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    modelContext.delete(location)
                                } label: {
                                    Label("delete", systemImage: "trash.fill")
                                }
                            }
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
                Button {
                    addLocationModalPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .padding()
                .fullScreenCover(isPresented: $addLocationModalPresented, content: AddLocationModalView.init)
            }
        }
    }
}

#Preview {
    ListView(locations: LocationModel.getLyonLocationsWithFullData())
}
