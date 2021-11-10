import SwiftUI

struct ArtistsListView: View {
    let artists = Artist.all

    var body: some View {
        List(artists) { artist in
            Text(artist.name)
        }
    }
}

struct ArtistsListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsListView()
    }
}
