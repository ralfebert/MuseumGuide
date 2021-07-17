import SwiftUI

struct NoImageAvailableError: Error {}

@MainActor
class RandomArtworkModel: ObservableObject {
    @Published var artworkResult: AsyncResult<Artwork> = .empty

    var objects: ArtworksResult?
    let endpoints = MetMuseumEndpoints()

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
        if objects == nil {
            await self.objects = try endpoints.search("van gogh")
        }

        guard let objects = objects, let randomObjectId = objects.objectIDs.randomElement() else {
            throw NoImageAvailableError()
        }

        return try await endpoints.artwork(id: randomObjectId)
    }
}
