import AsyncView
import MetMuseumEndpoints
import SwiftUI

struct RandomArtworkView: View {
    @StateObject var randomArtworkModel = AsyncModel { try await MetMuseumEndpoints.shared.randomArtwork(searchText: "van gogh") }

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            AsyncModelView(model: randomArtworkModel) { artwork in
                VStack(alignment: .leading) {
                    if let artworkImageUrl = artwork.primaryImageSmallURL {
                        AsyncImage(
                            url: artworkImageUrl,
                            content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            },
                            placeholder: {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            }
                        )
                    }
                    Text(
                        """
                        **\(artwork.title)**
                        \(artwork.artistDisplayName), \(artwork.objectDate)
                        """
                    )
                }
            }

            Button("Next", role: nil) {
                Task {
                    await self.randomArtworkModel.load()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
