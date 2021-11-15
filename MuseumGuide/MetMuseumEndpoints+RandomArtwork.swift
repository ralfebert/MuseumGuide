import AsyncView
import MetMuseumEndpoints

struct NoImageAvailableError: Error {}

extension MetMuseumEndpoints {
    func randomArtwork(searchText: String) async throws -> Artwork {
        let artworksSearchResult = try await search(query: searchText)

        guard let randomObjectId = artworksSearchResult.objectIDs.randomElement() else {
            throw NoImageAvailableError()
        }

        return try await artwork(id: randomObjectId)
    }
}
