import SwiftData
import MapKit
import SwiftUI

@Model
class LocationModel: Identifiable {
    var uuid = UUID().uuidString
    var latitude: Double
    var longitude: Double
    var name: String
    var address: String
    var type: LocationType
    var url: String?
    var phoneNumber: String?
    var closingTime: String?
    var minPrice: Double?
    var maxPrice: Double?
    var comment: String?
    var photos: [PhotoModel] = []
    
    init(coordinates: CLLocationCoordinate2D, name: String, address: String, type: LocationType, minPrice: Double? = nil, maxPrice: Double? = nil, phoneNumber: String? = nil, closingTime: String? = nil, url: String? = nil) {
        self.latitude = coordinates.latitude
        self.longitude = coordinates.longitude
        self.name = name
        self.address = address
        self.type = type
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.phoneNumber = phoneNumber
        self.closingTime = closingTime
    }
    
    func coordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func getLyonLocationsWithFullData() -> [LocationModel] {
        return [
            LocationModel(
                coordinates: CLLocationCoordinate2D(latitude: 45.7640, longitude: 4.8357),
                name: "Le Sucre",
                address: "50 Quai Rambaud, 69002 Lyon",
                type: .club,
                minPrice: 15.0,
                maxPrice: 50.0
            ),
            LocationModel(
                coordinates: CLLocationCoordinate2D(latitude: 45.7589, longitude: 4.8277),
                name: "Café des Négociants",
                address: "1 Place Francisque Régaud, 69002 Lyon",
                type: .restaurant,
                minPrice: 10.0,
                maxPrice: 40.0
            ),
            LocationModel(
                coordinates: CLLocationCoordinate2D(latitude: 45.7668, longitude: 4.8320),
                name: "Le Tabac du Rhône",
                address: "10 Rue de la République, 69002 Lyon",
                type: .tobacconist,
                minPrice: 1.0,
                maxPrice: 10.0
            ),
            LocationModel(
                coordinates: CLLocationCoordinate2D(latitude: 45.7594, longitude: 4.8467),
                name: "Part-Dieu Mall",
                address: "17 Boulevard Vivier-Merle, 69003 Lyon",
                type: .shop,
                minPrice: 5.0,
                maxPrice: 200.0
            ),
            LocationModel(
                coordinates: CLLocationCoordinate2D(latitude: 45.7507, longitude: 4.8361),
                name: "Vieux Lyon Market",
                address: "7 Place Saint-Jean, 69005 Lyon",
                type: .supermarket,
                minPrice: 2.0,
                maxPrice: 50.0
            ),
            LocationModel(
                coordinates: CLLocationCoordinate2D(latitude: 45.7485, longitude: 4.8370),
                name: "Les Terrasses de Lyon",
                address: "25 Montée Saint-Barthélémy, 69005 Lyon",
                type: .restaurant,
                minPrice: 20.0,
                maxPrice: 100.0
            )
        ].map { location in
            // Ajout des données supplémentaires
            location.photos = [
                PhotoModel(url: "https://picsum.photos/seed/\(location.name.replacingOccurrences(of: " ", with: ""))/200/300"),
                PhotoModel(url: "https://picsum.photos/seed/\(location.name.replacingOccurrences(of: " ", with: ""))/400/600")
            ]
            location.comment = "Lieu incroyable avec une vue magnifique."
            location.phoneNumber = "+33 1 01 01 01 01"
            return location
        }
    }
}
