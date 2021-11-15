import AsyncView
import MetMuseumEndpoints
import SwiftUI

struct GalleryView: View {
    @State var selectedID = 0
    let artist: Artist

    var body: some View {
        AsyncView(
            operation: {
                try await MetMuseumEndpoints().search(query: artist.name)
            },
            content: { searchResult in
                // Holding the selection here as @State is a workaround: Without it, the state changes
                // from the ArtworkViews inside causes the outer TabView to loose the selection state
                // in iOS 15.1 (seems like a SwiftUI bug, it should keep the state in that case)
                TabView(selection: $selectedID) {
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
