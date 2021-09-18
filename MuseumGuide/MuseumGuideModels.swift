import AsyncModel
import Foundation
import MetMuseumEndpoints

@MainActor
class ExhibitionsModel: AsyncModel<[Exhibition]> {
    let endpoints = ExhibitionsEndpoints()

    override func load() async throws -> [Exhibition] {
        try await self.endpoints.exhibitions()
    }
}

@MainActor
class ArtworkSearchModel: AsyncModel<ArtworksSearchResult> {
    var searchText: String
    let endpoints = MetMuseumEndpoints()

    init(searchText: String) {
        self.searchText = searchText
    }

    override func load() async throws -> ArtworksSearchResult {
        try await self.endpoints.search(query: self.searchText)
    }
}
