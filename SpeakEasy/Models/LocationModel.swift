//
//  LocationModel.swift
//  SpeakEasy
//
//  Created by Utilisateur invité on 10/12/2024.
//

import SwiftData
import SwiftUI

enum LocationType: String, CaseIterable, Codable {
    case bar = "bar"
    case restaurant = "restaurant"
    case club = "club"
    case tobacconist = "tobacconist"
    case shop = "shop"
    case supermarket = "supermarket"
}

@Model
class Location: Identifiable {
    var uuid = UUID().uuidString
    var long: String
    var lat: String
    var name: String
    var type: LocationType
    var tags: [String] = []
    var photos: [String] = []
    var minPrice: Double
    var maxPrice: Double
    var comments: [String] = []
    
    init(long: String, lat: String, name: String, type: LocationType, minPrice: Double, maxPrice: Double) {
        self.long = long
        self.lat = lat
        self.name = name
        self.type = type
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
}
