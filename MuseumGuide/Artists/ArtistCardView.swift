import SwiftUI

struct ArtistCardView: View {
    let artist: Artist

    var body: some View {
        Text(artist.name)
    }
}

struct ArtistCardView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistCardView(artist: Artist.all[0])
            .previewLayout(.sizeThatFits)
    }
}
