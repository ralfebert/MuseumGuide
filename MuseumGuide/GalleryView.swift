import AsyncModel
import SwiftUI

struct GalleryView: View {
    @StateObject var artworkSearchModel: ArtworkSearchModel

    var body: some View {
        ZStack {
            AsyncResultView(result: artworkSearchModel.result) { searchResult in
                TabView {
                    ForEach(searchResult.objectIDs, id: \.self) { objectID in
                        ArtworkView(artworkModel: ArtworkModel(objectID: objectID))
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
        .task {
            await artworkSearchModel.reload()
        }
    }
}
