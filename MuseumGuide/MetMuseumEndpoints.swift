import Foundation

struct ArtworksResult: Codable {
    var total: Int
    var objectIDs: [Int]
}

struct Artwork: Codable {
    let objectID: Int
    let isHighlight: Bool
    let accessionNumber, accessionYear: String
    let isPublicDomain: Bool
    let primaryImage, primaryImageSmall: String
    let additionalImages: [String]
    // let constituents: [Constituent]
    let department, objectName, title, culture: String
    let period, dynasty, reign, portfolio: String
    let artistRole, artistPrefix, artistDisplayName, artistDisplayBio: String
    let artistSuffix, artistAlphaSort, artistNationality, artistBeginDate: String
    let artistEndDate, artistGender: String
    // let artistWikidata_URL: String
    // let artistULAN_URL: String
    let objectDate: String
    let objectBeginDate, objectEndDate: Int
    let medium, dimensions: String
    // let measurements: JSONNull?
    let creditLine, geographyType, city, state: String
    let county, country, region, subregion: String
    let locale, locus, excavation, river: String
    let classification, rightsAndReproduction, linkResource, metadataDate: String
    let repository: String
    let objectURL: String
    // let tags: [Tag]
    let objectWikidata_URL: String
    let isTimelineWork: Bool
    let GalleryNumber: String

    var primaryImageSmallUrl: URL? {
        URL(string: primaryImageSmall)
    }
}

struct MetMuseumEndpoints {
    let baseURL = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/")!
    let urlSession = URLSession.shared
    let decoder = JSONDecoder()

    typealias Id = Int

    func search(_ query: String) async throws -> ArtworksResult {
        try await request(
            URLRequest(
                method: .get,
                url: baseURL.appendingPathComponent("search"),
                parameters: [
                    "q": query,
                    "artistOrCulture": "true",
                    "hasImages": "true",
                ]
            ),
            type: ArtworksResult.self
        )
    }

    func artwork(id: Id) async throws -> Artwork {
        try await request(
            URLRequest(
                method: .get,
                url: baseURL.appendingPathComponent("objects").appendingPathComponent(String(id))
            ),
            type: Artwork.self
        )
    }

    private func request<T: Decodable>(_ urlRequest: URLRequest, type _: T.Type) async throws -> T {
        let (data, response) = try await urlSession.data(for: urlRequest)
        try expectSuccess(response: response)
        return try decoder.decode(T.self, from: data)
    }

    private func expectSuccess(response: URLResponse) throws {
        let status = (response as! HTTPURLResponse).status
        guard status.responseType == .success else { throw status }
    }
}
