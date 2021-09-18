import AsyncModel
import SwiftUI

struct ExhibitionsView: View {
    @StateObject var exhibitionsModel = ExhibitionsModel()

    var body: some View {
        VStack {
            AsyncResultView(result: exhibitionsModel.result) { exhibitions in
                ScrollView(.vertical) {
                    VStack(spacing: 15) {
                        ForEach(exhibitions) { exhibition in
                            NavigationLink(
                                destination: {
                                    GalleryView(artworkSearchModel: ArtworkSearchModel(searchText: exhibition.name))
                                },
                                label: {
                                    ExhibitionCardView(exhibition: exhibition)
                                        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
                                }
                            )
                        }
                    }
                }
                .navigationBarTitle("Exhibitions")
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
