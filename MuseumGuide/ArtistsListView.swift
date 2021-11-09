import SwiftUI

struct ContentView: View {
    let artists = Artist.all

    var body: some View {
        List(artists) { artist in
            Text(artist.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
