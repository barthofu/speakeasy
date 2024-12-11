import SwiftUI
import MapKit
import iPhoneNumberField
import SimpleToast

struct AddLocationModalView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
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
    @State private var type = LocationType.bar
    @State private var comment = ""
    @State private var imageUrl = ""
    
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
                            Text(LocalizedStringKey(locationType.displayName)).tag(locationType)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    HStack {
                        TextField("Prix bas", value: $minPrice, format: .number)
                            .keyboardType(.decimalPad)
                        TextField("Prix haut", value: $maxPrice, format: .number)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Commentaire (optionnel)")) {
                    
                    TextEditor(text: $comment)
                }
                
                Button("Ajouter l'établissement") {
                    saveLocation()
                }
                    .disabled(
                        name.isEmpty
                        || address.isEmpty
                        || type.rawValue.isEmpty
                    )
            }
            .onChange(of: searchQuery) {
                locationService.update(queryFragment: searchQuery)
            }
            .navigationBarTitle("Ajouter un établissement")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .padding()
            }
            
        }
        .navigationViewStyle(.stack)
    }
        
    func saveLocation() {
        print("Nom: \(name), Adresse: \(selectedResult?.address ?? "")")
        
        guard let coordinates = self.selectedResult?.coordinates else {
            print("Erreur : Les coordonnées ne sont pas disponibles.")
            return
        }
                
        let newLocation = LocationModel(
            coordinates: coordinates,
            name: self.name,
            address: self.address,
            type: self.type,
            minPrice: self.minPrice,
            maxPrice: self.maxPrice,
            phoneNumber: self.phoneNumber,
            closingTime: self.closingTime,
            url: self.selectedResult?.url
        )
        newLocation.photos = [
            PhotoModel(url: "https://picsum.photos/seed/\(self.name.replacingOccurrences(of: " ", with: ""))/1280/720"),
            PhotoModel(url: "https://picsum.photos/seed/\(self.address.replacingOccurrences(of: " ", with: ""))/1280/720")
        ]
        if !comment.isEmpty {
            newLocation.comment = self.comment
        }
        
        do {
            modelContext.insert(newLocation)
            try modelContext.save()
            print("L'emplacement a été sauvegardé avec succès !")
            dismiss()
        } catch let error as NSError {
            print("Erreur lors de la sauvegarde : \(error), \(error.userInfo)")
        }
    }
}


#Preview {
    AddLocationModalView()
}
