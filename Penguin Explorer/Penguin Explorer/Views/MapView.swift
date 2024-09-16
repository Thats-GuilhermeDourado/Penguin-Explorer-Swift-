import SwiftUI
import MapKit
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}


struct PenguinHabitat: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let penguin: Penguin?
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -75.250973, longitude: -0.071389),
        span: MKCoordinateSpan(latitudeDelta: 50.0, longitudeDelta: 50.0)
    )
    
    @State private var selectedPenguin: Penguin?
    @State private var showDiscoveryAnimation = false
    @State private var discoveredPenguins: [Penguin] = []
    
    let habitats = [
        PenguinHabitat(name: "Antártida", coordinate: CLLocationCoordinate2D(latitude: -75.250973, longitude: -0.071389),
                       penguin: Penguin(name: "Pinguim Imperador", description: "Pinguins da Antártida")),
        PenguinHabitat(name: "Patagônia", coordinate: CLLocationCoordinate2D(latitude: -42.058, longitude: -64.848),
                       penguin: Penguin(name: "Pinguim de Magalhães", description: "Pinguins da Patagônia")),
        PenguinHabitat(name: "Ilhas Galápagos", coordinate: CLLocationCoordinate2D(latitude: -0.953969, longitude: -89.633867),
                       penguin: Penguin(name: "Pinguim das Galápagos", description: "Pinguins das Ilhas Galápagos"))
    ]
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: habitats) { habitat in
                MapPin(coordinate: habitat.coordinate)
            }
            .edgesIgnoringSafeArea(.all)
            .onChange(of: region.center) { newCenter in
                checkForNearbyPenguins(userLocation: newCenter)
            }
            
            if let selectedPenguin = selectedPenguin, showDiscoveryAnimation {
                VStack {
                    Text("Você encontrou um \(selectedPenguin.name)!")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    Button("Adicionar à Coleção") {
                        discoveredPenguins.append(selectedPenguin)
                        showDiscoveryAnimation = false
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .transition(.scale)
            }
        }
    }
    

    func checkForNearbyPenguins(userLocation: CLLocationCoordinate2D) {
        for habitat in habitats {
            let distance = getDistance(from: userLocation, to: habitat.coordinate)
            if distance < 1000 {
                if let penguin = habitat.penguin, !discoveredPenguins.contains(where: { $0.id == penguin.id }) {
                    selectedPenguin = penguin
                    showDiscoveryAnimation = true
                    return
                }
            }
        }
    }
    
    func getDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let fromLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let toLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return fromLocation.distance(from: toLocation)
    }
}

#Preview {
    MapView()
}
