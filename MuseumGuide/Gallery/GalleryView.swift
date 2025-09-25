import AsyncView
import MetMuseumEndpoints
import SwiftUI

struct GalleryView: View {
    let artist: Artist

    var body: some View {
        AsyncView(
            operation: {
                try await MetMuseumEndpoints().search(query: artist.name)
            },
            content: { searchResult in
                TabView {
                    ForEach(searchResult.objectIDs, id: \.self) { objectID in
                        ArtworkView(artworkId: objectID)
                      }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        )
        .navigationBarTitle(artist.name)
    }
}
