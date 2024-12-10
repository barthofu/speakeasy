import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack {
            // Contenu principal dans un ScrollView
            ScrollView {
                VStack(spacing: 15) { // Espacement réduit de manière modérée
                    // Image et titre
                    Image(systemName: "wineglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100) // Taille légèrement réduite
                        .foregroundColor(.white)
                        .background(Circle().fill(Color.brown).frame(width: 120, height: 120))
                    
                    Text("The Glory H")
                        .font(.title) // Taille de police modérée
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Bar")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Carrousel d'images
                    TabView {
                        ForEach(1...5, id: \.self) { index in
                            Image("image\(index)") // Remplacez par vos images dans les Assets
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200) // Hauteur ajustée modérément
                                .clipped()
                                .cornerRadius(10)
                                .padding(.horizontal, 10) // Espacement horizontal
                        }
                    }
                    .frame(height: 200) // Hauteur modérée du carrousel
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Style carrousel avec indicateurs
                    .padding(.vertical, 15) // Espacement vertical ajusté
                    
                    // Ligne avec deux boutons côte à côte
                    HStack(spacing: 20) { // Espacement légèrement augmenté entre les boutons
                        // Bouton Appeler
                        Button(action: {
                            print("Appeler")
                        }) {
                            VStack(spacing: 10) { // Espace vertical ajusté
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 30)) // Taille d'icône légèrement réduite
                                    .foregroundColor(.gray)
                                Text("Appeler")
                                    .font(.headline) // Taille du texte ajustée
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, minHeight: 90)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(12)
                        }
                        
                        // Bouton Voir le site web
                        Button(action: {
                            print("Voir le site web")
                        }) {
                            VStack(spacing: 10) { // Espace vertical ajusté
                                Image(systemName: "globe")
                                    .font(.system(size: 30)) // Taille d'icône légèrement réduite
                                    .foregroundColor(.gray)
                                Text("Voir le site web")
                                    .font(.headline) // Taille du texte ajustée
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, minHeight: 90)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(12)
                        }
                    }
                    
                    // Bouton "Laisser un commentaire" avec une icône
                    Button(action: {
                        print("Laisser un commentaire")
                    }) {
                        VStack(spacing: 10) { // Espace vertical ajusté
                            Image(systemName: "message.fill")
                                .font(.system(size: 30)) // Taille d'icône ajustée
                                .foregroundColor(.gray)
                            Text("Laisser un commentaire")
                                .font(.headline) // Taille du texte ajustée
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            
            // Barre de navigation en bas
            HStack {
                Button(action: {
                    print("Retour à l'accueil")
                }) {
                    VStack {
                        Image(systemName: "house.fill")
                            .font(.title2) // Taille de l'icône ajustée
                            .foregroundColor(.white)
                        Text("Accueil")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                
                Button(action: {
                    print("Vers la liste (non implémenté)")
                }) {
                    VStack {
                        Image(systemName: "list.bullet")
                            .font(.title2) // Taille de l'icône ajustée
                            .foregroundColor(.white)
                        Text("Liste")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.gray.opacity(0.2)) // Couleur de la barre
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Fond noir
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
