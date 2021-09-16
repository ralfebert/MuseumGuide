import MetMuseumEndpoints
import SwiftUI

@MainActor
class ArtworkSearchModel: ObservableObject {
    var searchText: String
    @Published var searchResult: ArtworksSearchResult?
    let endpoints = MetMuseumEndpoints()

    init(searchText: String) {
        self.searchText = searchText
    }

    func reload() async {
        do {
            self.searchResult = try await self.endpoints.search(query: self.searchText)
        } catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading: \(String(describing: error))")
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
