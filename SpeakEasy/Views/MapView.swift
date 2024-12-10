//
//  MapView.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 10/12/2024.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let adonys = CLLocationCoordinate2D(latitude: 45.767999, longitude: 4.8327272)
}

struct MapView: View {
    
    @State private var search: String = ""
    @State private var locationService = LocationService(completer: .init())
    
    var body: some View {
            
            Map(){

                //exemple :
                Annotation("Adonys", coordinate: .adonys, anchor: .bottom){
                    Image(systemName: "wineglass")
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(Color("Primary"))
                        .clipShape(Circle())
                }
            }
            .mapStyle(.imagery(elevation: .realistic))
        }
        
    }
    

#Preview {
    MapView()
}
