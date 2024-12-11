//
//  MapView.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 10/12/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var locationService = LocationService(completer: .init())
    @StateObject var manager = LocationManager()
    
    var listLocations: [LocationModel]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                Map(coordinateRegion: $manager.region, showsUserLocation: true, annotationItems: listLocations, annotationContent:
                        {
                    location in
                        
                    MapAnnotation(coordinate: location.coordinates()) {
                                Image(systemName: location.type.icon)
                                        .foregroundStyle(.white)
                                        .padding(8)
                                        .background(Color("Primary"))
                                        .clipShape(Circle())
                                        .shadow(radius: 4)
                                    
                                    Text(location.name)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                        .padding(4)
                                        .background(Color.white.opacity(0.9))
                                        .cornerRadius(8)
                            }
                            
                })
                .mapStyle(.imagery(elevation: .realistic))
                
                NavigationLink {
                    AddLocationView()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Color("White"))
                }.frame(width: 48, height: 48)
                    .background(Color("Gray"))
                    .cornerRadius(12)
                    .padding()
            }.navigationBarHidden(true)
        }
    }
}

#Preview {
    MapView(listLocations: LocationModel.getLyonLocationsWithFullData())
}
