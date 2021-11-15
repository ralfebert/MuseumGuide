import SwiftUI

@main
struct MuseumGuideApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ArtistsView()
            }
        }
    }
}
