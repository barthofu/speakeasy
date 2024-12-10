//
//  LocationModel.swift
//  SpeakEasy
//
//  Created by Utilisateur invité on 10/12/2024.
//

import SwiftData
import MapKit
import SwiftUI

enum LocationType: String, CaseIterable, Codable, Identifiable {
    case bar = "bar"
    case restaurant = "restaurant"
    case club = "club"
    case tobacconist = "tobacconist"
    case shop = "shop"
    case supermarket = "supermarket"
        
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .bar: return "Bar"
        case .restaurant: return "Restaurant"
        case .club: return "Club"
        case .tobacconist: return "Tobacconist"
        case .shop: return "Shop"
        case .supermarket: return "Supermarket"
        }
    }
    
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

struct Coordinate2D: Codable {
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

@Model
class LocationModel: Identifiable {
    var uuid = UUID().uuidString
    var coordinates: Coordinate2D
    var name: String
    var address: String
    var phoneNumber: String?
    var type: LocationType
    var tags: [String] = []
    var photos: [String] = []
    var minPrice: Double
    var maxPrice: Double
    var comments: [String] = []
    
    init(coordinates: Coordinate2D, name: String, address: String, type: LocationType, minPrice: Double, maxPrice: Double, phoneNumber: String? = nil) {
        self.coordinates = coordinates
        self.name = name
        self.address = address
        self.type = type
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.phoneNumber = phoneNumber
    }
    
    static func getLyonLocationsWithFullData() -> [LocationModel] {
        return [
            LocationModel(
                coordinates: Coordinate2D.init(latitude: 45.7640, longitude: 4.8357),
                name: "Le Sucre",
                address: "50 Quai Rambaud, 69002 Lyon",
                type: .club,
                minPrice: 15.0,
                maxPrice: 50.0
            ),
            LocationModel(
                coordinates: Coordinate2D.init(latitude: 45.7589, longitude: 4.8277),
                name: "Café des Négociants",
                address: "1 Place Francisque Régaud, 69002 Lyon",
                type: .restaurant,
                minPrice: 10.0,
                maxPrice: 40.0
            ),
            LocationModel(
                coordinates: Coordinate2D.init(latitude: 45.7668, longitude: 4.8320),
                name: "Le Tabac du Rhône",
                address: "10 Rue de la République, 69002 Lyon",
                type: .tobacconist,
                minPrice: 1.0,
                maxPrice: 10.0
            ),
            LocationModel(
                coordinates: Coordinate2D.init(latitude: 45.7594, longitude: 4.8467),
                name: "Part-Dieu Mall",
                address: "17 Boulevard Vivier-Merle, 69003 Lyon",
                type: .shop,
                minPrice: 5.0,
                maxPrice: 200.0
            ),
            LocationModel(
                coordinates: Coordinate2D.init(latitude: 45.7507, longitude: 4.8361),
                name: "Vieux Lyon Market",
                address: "7 Place Saint-Jean, 69005 Lyon",
                type: .supermarket,
                minPrice: 2.0,
                maxPrice: 50.0
            ),
            LocationModel(
                coordinates: Coordinate2D.init(latitude: 45.7485, longitude: 4.8370),
                name: "Les Terrasses de Lyon",
                address: "25 Montée Saint-Barthélémy, 69005 Lyon",
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
            location.phoneNumber = "+33 1 01 01 01 01"
            return location
        }
    }
}
