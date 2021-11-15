import AsyncView
import MetMuseumEndpoints
import SwiftUI

struct ArtworkView: View {
    let artworkId: Artwork.ID

    var body: some View {
        AsyncView(
            operation: {
                try await MetMuseumEndpoints().artwork(id: artworkId)
            },
            content: { artwork in
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

                    VStack(alignment: .leading) {
                        Text(
                            """
                            **\(artwork.title)**
                            \(artwork.artistDisplayName), \(artwork.objectDate)
                            """
                        )
                    }
                }
            }
        )
        .edgesIgnoringSafeArea(.top)
        .padding()
    }
}
