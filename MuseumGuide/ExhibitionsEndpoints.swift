import Foundation
import SweetURLRequest

struct Exhibition: Identifiable, Codable {
    var id: Int
    var name: String
    var previewImageUrl: URL
}

struct ExhibitionsEndpoints {
    let baseURL = URL(string: "https://www.ralfebert.de/examples/")!
    let urlSession: URLSession
    let decoder = JSONDecoder()

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    public func exhibitions() async throws -> [Exhibition] {
        try await self.request(
            URLRequest(
                method: .get,
                url: self.baseURL.appendingPathComponent("exhibitions.json")
            ),
            type: [Exhibition].self
        )
    }

    private func request<T: Decodable>(_ urlRequest: URLRequest, type: T.Type = T.self) async throws -> T {
        let (data, response) = try await urlSession.data(for: urlRequest)
        try self.expectSuccess(response: response)
        return try self.decoder.decode(type, from: data)
    }

    private func expectSuccess(response: URLResponse) throws {
        let status = (response as! HTTPURLResponse).status
        guard status.responseType == .success else { throw status }
    }
}
