//
//  LocationListItem.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 11/12/2024.
//

import SwiftUI

struct LocationListItem: View {
    var location: LocationModel
    
    var body: some View {
        HStack {
            Image(systemName: location.type.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
                .foregroundColor(Color("White"))
                .background(Circle().fill(Color("Primary"))
                    .frame(width: 50, height: 50))
                .shadow(radius: 15)
            VStack(alignment: .leading) {
                Text(location.name)
                    .bold()
                Text(location.type.displayName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

#Preview {
    LocationListItem(location: LocationModel.getLyonLocationsWithFullData()[0])
    LocationListItem(location: LocationModel.getLyonLocationsWithFullData()[1])
    LocationListItem(location: LocationModel.getLyonLocationsWithFullData()[2])
}
