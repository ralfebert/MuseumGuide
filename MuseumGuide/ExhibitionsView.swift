import SwiftUI

@MainActor
class ExhibitionsModel: ObservableObject {
    @Published var exhibitions = [Exhibition]()

    func reload() async {
        let url = URL(string: "https://www.ralfebert.de/examples/exhibitions.json")!
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            self.exhibitions = try JSONDecoder().decode([Exhibition].self, from: data)
        } catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}

struct ExhibitionsView: View {
    @StateObject var exhibitionsModel = ExhibitionsModel()

    var body: some View {
        List(exhibitionsModel.exhibitions) { exhibition in
            NavigationLink(
                destination: {
                    GalleryView(artworkSearchModel: ArtworkSearchModel(searchText: exhibition.name))
                },
                label: {
                    Text(exhibition.name)
                }
            )
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
