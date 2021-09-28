import AsyncModel
import MetMuseumEndpoints
import SwiftUI

struct NoImageAvailableError: Error {}

@MainActor
class RandomArtworkModel: AsyncModel<Artwork> {
    init(searchText: String) {
        super.init {
            let endpoints = MetMuseumEndpoints()
            let artworksSearchResult = try await endpoints.search(query: searchText)

            guard let randomObjectId = artworksSearchResult.objectIDs.randomElement() else {
                throw NoImageAvailableError()
            }

            return try await endpoints.artwork(id: randomObjectId)
        }
    }
}
