import SwiftData
import MapKit
import SwiftUI

@Model
class PhotoModel: Identifiable {
    var uuid = UUID().uuidString
    var url: String
    
    init(url: String) {
        self.url = url
    }
}
