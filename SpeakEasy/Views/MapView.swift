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
    
    var listLocations: [Location]
    
    var body: some View {
        Map(position: $position) {
            ForEach(listLocations) { location in
                if let latitude = Double(location.lat), let longitude = Double(location.long) {
                    Annotation(location.name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
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
        }
        .mapStyle(.imagery(elevation: .realistic))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MapView(listLocations: Location.getLyonLocationsWithFullData())
}
