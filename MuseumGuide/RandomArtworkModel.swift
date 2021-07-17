import SwiftUI

struct NoImageAvailableError: Error {}

@MainActor
class RandomArtworkModel: ObservableObject {
    let searchText: String
    let endpoints = MetMuseumEndpoints()
    @Published var artworkResult = AsyncResult<Artwork>()
    private var artworksSearchResult: ArtworksSearchResult?

    init(searchText: String) {
        self.searchText = searchText
    }

    func reload() async {
        if artworkResult.inProgress { return }
        artworkResult.startProgress()

        do {
            artworkResult.finish(value: try await loadRandomArtwork())
        } catch {
            artworkResult.finish(error: error)
        }
    }

    func loadRandomArtwork() async throws -> Artwork {
        if artworksSearchResult == nil {
            await artworksSearchResult = try endpoints.search(query: searchText)
        }

        guard let objects = artworksSearchResult, let randomObjectId = objects.objectIDs.randomElement() else {
            throw NoImageAvailableError()
        }

        return try await endpoints.artwork(id: randomObjectId)
    }
}
