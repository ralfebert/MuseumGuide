import SwiftUI

struct NoImageAvailableError: Error {}

@MainActor
class RandomArtworkModel: ObservableObject {
    let endpoints = MetMuseumEndpoints()

    @Published var artworkResult: AsyncResult<Artwork> = .empty
    var artworksSearchResult: ArtworksSearchResult?

    func reload() async {
        if case .inProgress = artworkResult {
            return
        }
        artworkResult = .inProgress

        do {
            artworkResult = .success(try await loadRandomArtwork())
        } catch {
            artworkResult = .failure(error)
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
