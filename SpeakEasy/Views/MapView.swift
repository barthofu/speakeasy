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
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 45.7640, longitude: 4.8357),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    var listLocations: [LocationModel]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                Map(position: $position) {
                    ForEach(listLocations) { location in
                        Annotation(location.name, coordinate: location.coordinates()) {
                            NavigationLink {
                                DetailView(location: location)
                            } label: {
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
                        .annotationTitles(.hidden)
                    }
                }
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
