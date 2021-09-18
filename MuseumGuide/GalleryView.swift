import MetMuseumEndpoints
import SwiftUI

@MainActor
class AsyncModel<T>: ObservableObject {

    @Published var result: Result<T, Error>?

    func reload() async {
        do {
            let searchResult = try await self.load()
            self.result = .success(searchResult)
        } catch {
            self.result = .failure(error)
        }
        
    }
    
    func load() async throws -> T {
        fatalError("AsyncModel#load needs to be overriden")
    }

}

@MainActor
class ArtworkSearchModel: AsyncModel<ArtworksSearchResult> {
    var searchText: String
    let endpoints = MetMuseumEndpoints()

    init(searchText: String) {
        self.searchText = searchText
    }
    
    override func load() async throws -> ArtworksSearchResult {
        try await endpoints.search(query: searchText)
    }

}

struct AsyncResultView<T, Content>: View where Content: View {
    
    var result: Result<T, Error>?
    var content: (T) -> Content
 
    var body: some View {
        switch(result) {
        case .none:
            Text("noch nicht")
        case .success(let result):
            content(result)
        case .failure(let error):
            Text("Fehler \(error.localizedDescription)")
        }
    }
    
}


struct GalleryView: View {
    @ObservedObject var artworkSearchModel: ArtworkSearchModel

    var body: some View {
        AsyncResultView(result: artworkSearchModel.result) { searchResult in
            List(searchResult.objectIDs, id: \.self) { objectID in
                Text("\(objectID)")
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
