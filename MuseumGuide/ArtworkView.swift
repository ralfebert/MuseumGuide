import AsyncModel
import SwiftUI

struct ArtworkView: View {
    @ObservedObject var artworkModel: ArtworkModel

    var body: some View {
        ZStack {
            AsyncResultView(result: artworkModel.result) { artwork in
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

                    VStack(alignment: .leading) {
                        Text(artwork.title)
                            .bold()
                        Text(artwork.artistDisplayName + ", " + artwork.objectDate)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .padding()
        .task {
            await artworkModel.reload()
        }
    }
}
