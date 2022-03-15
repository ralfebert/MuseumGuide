import Foundation

public struct Artist: Identifiable {
    public var id: Int
    public var name: String
    public var previewImageUrl: URL

    static let all: [Artist] = {
        // TODO: artists.json via JSONDecoder laden
        [Artist(id: 1, name: "Vincent van Gogh", previewImageUrl: URL(string: "https://images.metmuseum.org/CRDImages/ep/web-large/DT1567.jpg")!)]
    }()
}
