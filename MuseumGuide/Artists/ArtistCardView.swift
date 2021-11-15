import SwiftUI

struct ArtistCardView: View {
    let artist: Artist

    let shape = RoundedRectangle(cornerRadius: 16)

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(
                url: artist.previewImageUrl,
                content: { image in
                    image
                        .resizable()
                        .scaleEffect(1.1)
                },
                placeholder: {
                    Color.yellow
                }
            )
            .aspectRatio(4 / 3, contentMode: .fit)

            Text(artist.name)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding()
                .padding(.top, 40)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [.clear, .black.opacity(3 / 4)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        }
        .frame(maxWidth: .infinity)
        .clipShape(shape)
        .overlay(shape.stroke(.gray, lineWidth: 0.5))
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}

struct ArtistCardView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistCardView(artist: Artist.all[0])
            .previewLayout(.sizeThatFits)
    }
}
