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
    @State private var addLocationModalPresented = false
    @StateObject var manager = LocationManager()
    
    var listLocations: [LocationModel]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                Map(coordinateRegion: $manager.region, showsUserLocation: true, annotationItems: listLocations, annotationContent:
                        {
                    location in
                    
                    MapAnnotation(coordinate: location.coordinates()) {
                        NavigationLink(destination: DetailView(location: location)) {
                            VStack {
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
                        }
                    }
                    
                })
                .edgesIgnoringSafeArea(.top)
                .mapStyle(.imagery(elevation: .realistic))
                
                Button {
                    addLocationModalPresented.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Color("White"))
                }
                .frame(width: 48, height: 48)
                .background(Color("Gray"))
                .cornerRadius(12)
                .padding()
                .fullScreenCover(isPresented: $addLocationModalPresented, content: AddLocationModalView.init)
            }
        }
    }
}

#Preview {
    MapView(listLocations: LocationModel.getLyonLocationsWithFullData())
}
