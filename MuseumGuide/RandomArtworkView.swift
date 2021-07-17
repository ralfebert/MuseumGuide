import SwiftUI

struct RandomArtworkView: View {
    @StateObject var randomArtworkModel = RandomArtworkModel(searchText: "van gogh")

    var body: some View {
        VStack(spacing: 20) {
            AsyncResultView(result: randomArtworkModel.artworkResult) { artwork in
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
