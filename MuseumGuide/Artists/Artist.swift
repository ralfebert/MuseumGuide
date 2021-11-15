import Foundation

public struct Artist: Identifiable, Codable {
    public var id: Int
    public var name: String
    public var previewImageUrl: URL
}

public extension Artist {
    static let all: [Artist] = [
        Artist(
            id: 1,
            name: "Vincent van Gogh",
            previewImageUrl: URL(string: "https://images.metmuseum.org/CRDImages/ep/web-large/DT1567.jpg")!
        ),
        Artist(
            id: 2,
            name: "Auguste Renoir",
            previewImageUrl: URL(string: "https://images.metmuseum.org/CRDImages/rl/web-large/DT3304.jpg")!
        ),
        Artist(
            id: 3,
            name: "Paul Cézanne",
            previewImageUrl: URL(string: "https://images.metmuseum.org/CRDImages/ep/web-large/DT1029.jpg")!
        ),
    ]
}
