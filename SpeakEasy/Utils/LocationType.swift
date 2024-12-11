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
