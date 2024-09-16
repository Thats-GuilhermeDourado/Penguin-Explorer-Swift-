import SwiftUI

struct Penguin: Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

struct PenguinCollectionView: View {
    let penguins: [Penguin]
    
    var body: some View {
        List(penguins) { penguin in
            VStack(alignment: .leading) {
                Text(penguin.name).font(.headline)
                Text(penguin.description).font(.subheadline)
            }
        }
    }
}

#Preview {
    PenguinCollectionView(penguins: [
        Penguin(name: "Pinguim Imperador", description: "Pinguins da Antártida"),
        Penguin(name: "Pinguim de Magalhães", description: "Pinguins da Patagônia")
    ])
}
