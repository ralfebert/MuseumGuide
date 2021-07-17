import SwiftUI

struct NoImageAvailableError: Error {}

@MainActor
class RandomArtworkModel: ObservableObject {
    let endpoints = MetMuseumEndpoints()

    @Published var artworkResult = AsyncResult<Artwork>()
    var artworksSearchResult: ArtworksSearchResult?

    func reload() async {
        if artworkResult.inProgress { return }
        artworkResult.inProgress = true

        do {
            artworkResult = AsyncResult(value: try await loadRandomArtwork())
        } catch {
            artworkResult = AsyncResult(error: error)
        }
    }

    func loadRandomArtwork() async throws -> Artwork {
        if artworksSearchResult == nil {
            await artworksSearchResult = try endpoints.search("van gogh")
        }

        guard let objects = artworksSearchResult, let randomObjectId = objects.objectIDs.randomElement() else {
            throw NoImageAvailableError()
        }

        return try await endpoints.artwork(id: randomObjectId)
    }
}
