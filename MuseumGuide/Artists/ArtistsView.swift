import AsyncView
import SwiftUI

struct ArtistsView: View {
    let artists = Artist.all

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                ForEach(artists) { artist in
                    NavigationLink(
                        destination: {
                            GalleryView(artist: artist)
                        },
                        label: {
                            ArtistCardView(artist: artist)
                        }
                    )
                }
            }
        }
        .navigationTitle("Artists")
    }
}

struct ExhibitionsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView()
    }
}
