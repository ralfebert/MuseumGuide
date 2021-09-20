import Foundation
import SwiftUI

struct Exhibition: Identifiable {
    var id = UUID()
    var name: String
}

struct Artwork: Identifiable {
    var id = UUID()
    var name: String
}

class ExhibitionsModel: ObservableObject {
    @Published var exhibitions = [Exhibition(name: "Picasso"), Exhibition(name: "Van Gogh")]
}

class ArtistModel: ObservableObject {
    let name: String
    @Published var artworks = [Artwork(name: "Artwork 1"), Artwork(name: "Artwork 2")]

    init(name: String) {
        self.name = name
    }
}

@main
struct MuseumGuideApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ExhibitionsView()
            }
        }
    }
}

struct ExhibitionsView: View {
    @StateObject var exhibitionsModel = ExhibitionsModel()

    var body: some View {
        List {
            ForEach(exhibitionsModel.exhibitions) { exhibition in
                NavigationLink(
                    destination: {
                        ArtistView(artistModel: ArtistModel(name: exhibition.name))
                    },
                    label: {
                        Text(exhibition.name)
                    }
                )
            }
        }
        .navigationTitle("Exhibitions")
    }
}

struct ArtistView: View {
    @ObservedObject var artistModel: ArtistModel

    var body: some View {
        List(artistModel.artworks) { artwork in
            Text(artwork.name)
        }
        .navigationTitle(artistModel.name)
    }
}
