import SwiftUI

struct DetailView: View {
    var location: LocationModel
    
    var body: some View {
        ScrollView {
            VStack {
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
                    .padding(.top)
                
                Text(LocalizedStringKey(location.type.displayName))
                    .font(.subheadline)
                    .opacity(0.5)
                
                Text(location.address)
                    .font(.subheadline)
                
                // Carrousel d'images
                TabView {
                    ForEach(location.photos.indices) { index in
                        AsyncImage(url: URL(string: location.photos[index].url))
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
                    VStack(spacing: 10) {
                        HStack(spacing: 10) {
                            Image(systemName: "clock")
                                .font(.system(size: 30))
                                .foregroundColor(Color("Gray").opacity(0.8))
                            Text("Closing")
                                .font(.headline)
                                .foregroundColor(Color.secondary)
                        }
                        
                        if(location.closingTime != nil && !location.closingTime!.isEmpty) {
                            Text(location.closingTime!)
                        } else {
                            Text(LocalizedStringKey("No info"))
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 90)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    
                    VStack(spacing: 10) {
                        HStack(spacing: 10) {
                            Image(systemName: "eurosign.circle")
                                .font(.system(size: 30))
                                .foregroundColor(Color("Gray").opacity(0.8))
                            Text("Price")
                                .font(.headline)
                                .foregroundColor(Color.secondary)
                        }
                        
                        if(location.minPrice != nil && location.maxPrice != nil) {
                            Text(String(format : "%.2f€ - %.2f€", locale: Locale.current, location.minPrice!, location.maxPrice!))
                        } else {
                            Text(LocalizedStringKey("No info"))
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 90)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                }.padding(.bottom, 10)
                
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
                                URL(string: location.url ?? "https://www.google.com/search?q=\(location.name)+ \(location.address)")!
                            )
                        }
                    )
                }
                
                if(location.comment != nil && !location.comment!.isEmpty) {
                    Text(location.comment!)
                        .padding()
                }
            }.padding()
        }
    }
}

#Preview {
    DetailView(location: LocationModel.getLyonLocationsWithFullData()[0])
}
