import SwiftUI

struct DetailView: View {
    var location: LocationModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Image(systemName: location.type.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .padding()
                    .foregroundColor(Color("White"))
                    .background(Circle().fill(Color("Primary")).frame(width: 120, height: 120))
                    .shadow(radius: 15)
                
                Text(location.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(location.type.rawValue.capitalized)
                    .font(.subheadline)
                    .opacity(0.5)
                
                // Carrousel d'images
                TabView {
                    ForEach(location.photos.indices) { index in
                        AsyncImage(url: URL(string: location.photos[index]))
                            .frame(height: 200)
                            .scaledToFill()
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(10)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .padding(.vertical, 15)
                
                
                HStack(spacing: 20) {
                    GlassedButton(
                        systemImageName: "phone.fill",
                        text: "Call",
                        action: {
                            UIApplication.shared.open(
                                URL(string: "tel://\(location.phoneNumber ?? "")")!
                            )
                        }
                    )
                    
                    GlassedButton(
                        systemImageName: "globe",
                        text: "See the website",
                        action: {
                            UIApplication.shared.open(
                                URL(string: "https://www.google.fr")!
                            )
                        }
                    )
                }
            
            }.padding()
        }
    }
}

#Preview {
    DetailView(location: LocationModel.getLyonLocationsWithFullData()[0])
}
