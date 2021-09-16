import Foundation
import SweetURLRequest

struct ArtworksSearchResult: Codable {
    /// The total number of publicly-available objects
    var total: Int

    /// An array containing the object ID of publicly-available object
    var objectIDs: [Int]
}

struct MetMuseumEndpoints {
    let baseURL = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/")!
    let urlSession: URLSession
    let decoder = JSONDecoder()

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func search(query: String) async throws -> ArtworksSearchResult {
        try await self.request(
            URLRequest(
                method: .get,
                url: self.baseURL.appendingPathComponent("search"),
                parameters: ["q": query]
            ),
            type: ArtworksSearchResult.self
        )
    }

    private func request<T: Decodable>(_ urlRequest: URLRequest, type _: T.Type) async throws -> T {
        let (data, response) = try await urlSession.data(for: urlRequest)
        try self.expectSuccess(response: response)
        return try self.decoder.decode(T.self, from: data)
    }

    private func expectSuccess(response: URLResponse) throws {
        let status = (response as! HTTPURLResponse).status
        guard status.responseType == .success else { throw status }
    }
}
