//
//  LocationModel.swift
//  SpeakEasy
//
//  Created by Utilisateur invité on 10/12/2024.
//

import SwiftData
import SwiftUI

enum LocationType {
    case bar, restaurant, club, tobacconist, shop, supermarket
}

@Model
class Location: Identifiable {
    var uuid = UUID()
    var long: String
    var lat: String
    var name: String
    var type: LocationType
    var tags: [String] = []
    var photos: [String] = []
    var minPrice: Float
    var maxPrice: Float
    var comments: [String] = []
    
    init(long: String, lat: String, name: String, type: LocationType, minPrice: Float, maxPrice: Float) {
        self.long = long
        self.lat = lat
        self.name = name
        self.type = type
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
}
