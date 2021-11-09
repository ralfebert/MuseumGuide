import AsyncModel
import SwiftUI

struct RandomArtworkView: View {
    @StateObject var randomArtworkModel = RandomArtworkModel(searchText: "van gogh")

    var body: some View {
        VStack(spacing: 20) {
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
                            }
                        )
                    }
                    Text(artwork.title)
                        .bold()
                    Text(artwork.artistDisplayName + ", " + artwork.objectDate)

                    Button("Next", role: nil) {
                        Task {
                            await self.randomArtworkModel.load()
                        }
                    }
                }
            }

            .buttonStyle(.bordered)
        }
        .padding()
    }
}
