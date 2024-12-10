//
//  LocationService.swift
//  SpeakEasy
//
//  Created by Utilisateur invité on 10/12/2024.
//

import MapKit

struct SearchResult: Identifiable {
    let id = UUID()
    let coordinates: CLLocationCoordinate2D
    let name: String
    let address: String
    let type: String?
    let phoneNumber: String?
}

@Observable
class LocationService: NSObject, MKLocalSearchCompleterDelegate {
    private let completer: MKLocalSearchCompleter

    var results = [SearchResult]()

    init(completer: MKLocalSearchCompleter) {
        self.completer = completer
        super.init()
        self.completer.delegate = self
    }

    func update(queryFragment: String) {
        completer.resultTypes = .pointOfInterest
        completer.queryFragment = queryFragment
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results.compactMap { completion in // ref: https://developer.apple.com/documentation/mapkit/mklocalsearchcompletion#1657948
            let mapItem = completion.value(forKey: "_mapItem") as? MKMapItem // ref: https://developer.apple.com/documentation/mapkit/mkmapitem#1657975

            return .init(
                coordinates: mapItem?.placemark.coordinate ?? CLLocationCoordinate2D.init(),
                name: completion.title,
                address: completion.subtitle,
                type: mapItem?.pointOfInterestCategory?.rawValue.replacingOccurrences(of: "MKPOICategory", with: "").lowercased(),
                phoneNumber: mapItem?.phoneNumber
            )
        }
    }
}
