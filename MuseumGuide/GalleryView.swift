import SwiftUI

struct ArtworksSearchResult: Codable {
    /// The total number of publicly-available objects
    var total: Int

    /// An array containing the object ID of publicly-available object
    var objectIDs: [Int]
}

@MainActor
class ArtworkSearchModel: ObservableObject {
    var searchText: String
    @Published var searchResult: ArtworksSearchResult?

    init(searchText: String) {
        self.searchText = searchText
    }

    func reload() async {
        let url = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/search?q=sunflowers")!
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            self.searchResult = try JSONDecoder().decode(ArtworksSearchResult.self, from: data)
        } catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}

struct GalleryView: View {
    @ObservedObject var artworkSearchModel: ArtworkSearchModel

    var body: some View {
        VStack {
            if let searchResult = artworkSearchModel.searchResult {
                List(searchResult.objectIDs, id: \.self) { objectID in
                    Text("\(objectID)")
                }
            }
        }
        .task {
            await self.artworkSearchModel.reload()
        }
    }
}

struct ExhibitionView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(artworkSearchModel: ArtworkSearchModel(searchText: "sunflower"))
    }
}
