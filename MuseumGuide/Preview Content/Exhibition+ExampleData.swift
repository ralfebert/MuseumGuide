import Foundation

extension Exhibition {
    static let exampleData: [Exhibition] = [
        .init(
            id: 1,
            name: "Vincent van Gogh",
            previewImageUrl: URL(string: "https://images.metmuseum.org/CRDImages/ep/web-large/DT1567.jpg")!
        ),
        .init(
            id: 2,
            name: "Auguste Renoir",
            previewImageUrl: URL(string: "https://images.metmuseum.org/CRDImages/rl/web-large/DT3304.jpg")!
        ),
        .init(
            id: 3,
            name: "Paul Cézanne",
            previewImageUrl: URL(string: "https://images.metmuseum.org/CRDImages/ep/web-large/DT1029.jpg")!
        ),
    ]
}
