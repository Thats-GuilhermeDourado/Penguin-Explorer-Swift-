import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Image("penguincute")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding(.top, 50)
                
                Spacer()
                
                
                NavigationLink(destination: MapView()) {
                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(.white)
                        Text("Explorar novos lugares")
                            .fontWeight(.bold)
                            .font(.system(.title3))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 300, height: 75, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                }
                
                
                
                HStack {
                    (destination: PenguinCollectionView()); {
                        HStack {
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.white)
                            Text("Coleção de Pinguins")
                                .fontWeight(.bold)
                                .font(.system(.title3))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .frame(width: 300, height: 75, alignment: .center)
                        .background(Color.green)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .padding()
                    }
                    
                    Spacer()
                }
            }
        }
        
        #Preview {
            ContentView()
        }
    }
}
