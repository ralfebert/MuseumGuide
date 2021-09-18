import AsyncModel
import SwiftUI

struct ExhibitionsView: View {
    @StateObject var exhibitionsModel = ExhibitionsModel()

    var body: some View {
        VStack {
            AsyncResultView(result: exhibitionsModel.result) { exhibitions in
                List(exhibitions) { exhibition in
                    NavigationLink(
                        destination: {
                            GalleryView(artworkSearchModel: ArtworkSearchModel(searchText: exhibition.name))
                        },
                        label: {
                            Text(exhibition.name)
                        }
                    )
                }
            }
        }
        .task {
            await self.exhibitionsModel.reload()
        }
        .refreshable {
            await self.exhibitionsModel.reload()
        }
        .navigationTitle("Exhibitions")
    }
}

struct ExhibitionsView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionsView()
    }
}
