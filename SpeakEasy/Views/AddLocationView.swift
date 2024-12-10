import SwiftUI
import MapKit
import iPhoneNumberField

let COMMENT_PLACEHOLDER = "Commentaire"

struct AddLocationView: View {
    
    @State private var locationService = LocationService(completer: .init())
    @State private var searchQuery = ""
    @State private var selectedResult: SearchResult?
    @State private var isShowingResults = false
    @State private var name = ""
    @State private var address = ""
    @State private var closingTime = ""
    @State private var phoneNumber = ""
    @State private var minPrice: Double? = nil
    @State private var maxPrice: Double? = nil
    @State private var type = LocationType.bar.rawValue
    @State private var comment = COMMENT_PLACEHOLDER
    @State private var imageUrl = ""
    
    @State private var fetchedImageUrls: [String] = []
    
    let locationManager = CLLocationManager()

    var body: some View {
        NavigationView {
            Form {
                TextField("Rechercher une addresse ou un lieu", text: $searchQuery, onEditingChanged: { isEditing in
                    // Affiche la liste si l'utilisateur édite le champ de recherche
                    isShowingResults = isEditing && !searchQuery.isEmpty
                })
                    .autocorrectionDisabled()
                    .onChange(of: searchQuery) {
                        locationService.update(queryFragment: searchQuery)
                        isShowingResults = !searchQuery.isEmpty
                    }
                
                Section(header: Text("Informations de l'établissement")) {
                    
                    if isShowingResults {
                        List {
                            ForEach(locationService.results) { result in
                                Button(action: {
                                    selectedResult = result
                                    name = result.name
                                    address = result.address
                                    phoneNumber = result.phoneNumber ?? ""
                                    isShowingResults = false
                                 }) {
                                     VStack(alignment: .leading, spacing: 4) {
                                         Text(result.name)
                                             .font(.headline)
                                             .fontDesign(.rounded)
                                         Text(result.address)
                                     }
                                 }
                                 .listRowBackground(Color.clear)
                            }
                        }
                    }
                    
                    TextField("Nom", text: $name)
                    
                    TextField("Addresse", text: $address)
                    
                    TextField("Heure de fermeture", text: $closingTime)
                                        
                    iPhoneNumberField("Téléphone", text: $phoneNumber)
                        .flagHidden(false)
                        .flagSelectable(true)
                        .prefixHidden(false)
                    
                    Picker("Type", selection: $type) {
                        ForEach(LocationType.allCases) { locationType in
                            Text(locationType.displayName).tag(locationType)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    HStack {
                        TextField("Prix bas", value: $minPrice, format: .number)
                            .keyboardType(.decimalPad)
                        TextField("Prix haut", value: $maxPrice, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    
                    TextEditor(text: $comment)
                        .foregroundColor(self.comment == COMMENT_PLACEHOLDER ? .gray : .primary)
                        .onTapGesture {
                            if self.comment == COMMENT_PLACEHOLDER {
                                self.comment = ""
                            }
                        }
                }
                
                Button("Ajouter l'établissement") {
                    saveLocation()
                }
                    .disabled(
                        name.isEmpty
                        || address.isEmpty
                        || type.isEmpty
                    )
                
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
        .navigationViewStyle(.stack)
    }
        
    func saveLocation() {
        print("Nom: \(name), Adresse: \(selectedResult?.address ?? "")")
        
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
    AddLocationView()
}
