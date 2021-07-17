import SweetURLRequest
import SwiftUI

struct RandomArtworkView: View {
    @StateObject var randomArtworkModel = RandomArtworkModel()

    var body: some View {
        VStack(spacing: 20) {
            AsyncResultView(result: randomArtworkModel.artworkResult) { artwork in
                VStack(alignment: .leading) {
                    if let artworkImageUrl = artwork.primaryImageSmallUrl {
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
                    Text(artwork.artistDisplayName)
                }
            }

            Button("Next", role: nil) {
                Task {
                    await self.randomArtworkModel.reload()
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .task {
            await self.randomArtworkModel.reload()
        }
    }
}
