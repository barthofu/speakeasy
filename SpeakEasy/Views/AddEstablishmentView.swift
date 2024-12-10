import SwiftUI
import MapKit

struct AddEstablishmentView: View {
    @State private var locationService = LocationService(completer: .init())
    @State private var searchQuery = ""
    @State public var searchResults: [MKLocalSearchCompletion] = []
    @State private var selectedAddress: MKLocalSearchCompletion?
    @State private var name = ""
    @State private var closingTime = ""
    @State private var imageUrl = ""
    
    // Liens d'images fictifs pour démonstration
    @State private var fetchedImageUrls: [String] = []
    
    let locationManager = CLLocationManager()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informations de l'établissement")) {
                    TextField("Rechercher une addresse ou un lieu", text: $searchQuery)
                        .autocorrectionDisabled()
                    
                    List {
                        ForEach(locationService.completions) { completion in
                            Button(action: { }) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(completion.title)
                                        .font(.headline)
                                        .fontDesign(.rounded)
                                    Text(completion.subTitle)
                                }
                            }
                            // 3
                            .listRowBackground(Color.clear)
                        }
                    }
                    
                    TextField("Heure de fermeture", text: $closingTime)
                        .keyboardType(.numberPad)
                    
                    TextField("URL des images", text: $imageUrl)
                        .keyboardType(.URL)
                    
                    if let selectedAddress = selectedAddress {
                        VStack(alignment: .leading) {
                            Text("Adresse sélectionnée :")
                            Text(selectedAddress.title)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(selectedAddress.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 10)
                    }
                    
                    if !searchResults.isEmpty {
                        Section(header: Text("Suggestions d'adresses")) {
                            List(searchResults, id: \.self) { result in
                                Button(action: {
                                    selectedAddress = result
                                    searchQuery = result.title
                                }) {
                                    Text(result.title)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    
                    Button("Ajouter l'établissement") {
                        saveEstablishment()
                    }
                    .disabled(name.isEmpty || closingTime.isEmpty || searchQuery.isEmpty)
                }
                
                if !fetchedImageUrls.isEmpty {
                    Section(header: Text("Images disponibles")) {
                        ForEach(fetchedImageUrls, id: \.self) { imageUrl in
                            Text(imageUrl)
                                .font(.body)
                        }
                    }
                }
            }
            .onChange(of: searchQuery) {
                locationService.update(queryFragment: searchQuery)
            }
            .navigationBarTitle("Ajouter un établissement")
        }
    }
        
    func saveEstablishment() {
        print("Nom: \(name), Adresse: \(selectedAddress?.title ?? "")")
        
        fetchImageUrls()
    }
    
    func fetchImageUrls() {
        fetchedImageUrls = [
            "https://example.com/image1.jpg",
            "https://example.com/image2.jpg"
        ]
    }
}


#Preview {
    AddEstablishmentView()
}
