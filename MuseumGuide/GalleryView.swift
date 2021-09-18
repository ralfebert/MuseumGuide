import AsyncModel
import MetMuseumEndpoints
import SwiftUI

struct GalleryView: View {
    @ObservedObject var artworkSearchModel: ArtworkSearchModel

    var body: some View {
        VStack {
            AsyncResultView(result: artworkSearchModel.result) { searchResult in
                List(searchResult.objectIDs, id: \.self) { objectID in
                    Text("\(objectID)")
                }
            }
        }
        .task {
            await self.artworkSearchModel.reload()
        }
    }
}

struct ExhibitionView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(artworkSearchModel: ArtworkSearchModel(searchText: "sunflower"))
    }
}
