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
    
    
    var icon: String {
        switch self {
        case .bar:
            return "wineglass"
        case .restaurant:
            return "fork.knife"
        case .club:
            return "figure.dance"
        case .tobacconist:
            return "carrot"
        case .shop :
            return "basket"
        case .supermarket:
            return "eurosign.bank.building.fill"
        }
    }

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
    
    static func getLyonLocationsWithFullData() -> [Location] {
        return [
            Location(
                long: "4.8357",
                lat: "45.7640",
                name: "Le Sucre",
                type: .club,
                minPrice: 15.0,
                maxPrice: 50.0
            ),
            Location(
                long: "4.8277",
                lat: "45.7589",
                name: "Café des Négociants",
                type: .restaurant,
                minPrice: 10.0,
                maxPrice: 40.0
            ),
            Location(
                long: "4.8320",
                lat: "45.7668",
                name: "Le Tabac du Rhône",
                type: .tobacconist,
                minPrice: 1.0,
                maxPrice: 10.0
            ),
            Location(
                long: "4.8467",
                lat: "45.7594",
                name: "Part-Dieu Mall",
                type: .shop,
                minPrice: 5.0,
                maxPrice: 200.0
            ),
            Location(
                long: "4.8361",
                lat: "45.7507",
                name: "Vieux Lyon Market",
                type: .supermarket,
                minPrice: 2.0,
                maxPrice: 50.0
            ),
            Location(
                long: "4.8370",
                lat: "45.7485",
                name: "Les Terrasses de Lyon",
                type: .restaurant,
                minPrice: 20.0,
                maxPrice: 100.0
            )
        ].map { location in
            // Ajout des données supplémentaires
            location.tags = ["popular", "Lyon", "trendy"]
            location.photos = [
                "https://picsum.photos/seed/\(location.name.replacingOccurrences(of: " ", with: ""))/200/300",
                "https://picsum.photos/seed/\(location.name.replacingOccurrences(of: " ", with: ""))/400/600"
            ]
            location.comments = [
                "Lieu incroyable avec une vue magnifique.",
                "Super service et ambiance au top !",
                "J’y retournerai sans hésiter."
            ]
            return location
        }
    }
}
