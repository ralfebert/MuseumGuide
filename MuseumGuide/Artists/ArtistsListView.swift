import SwiftUI

struct ArtistsListView: View {
    let artists = Artist.all

    var body: some View {
        List(artists) { artist in
            ArtistCardView(artist: artist)
        }
    }
}

struct ArtistsListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsListView()
    }
}
