import SwiftUI

struct ExhibitionCardView: View {
    let exhibition: Exhibition

    var shape = RoundedRectangle(cornerRadius: 16, style: .continuous)

    var body: some View {
        Color.yellow
            .frame(height: 250)
            .frame(maxWidth: .infinity)
            .overlay(backgroundImage)
            .overlay(alignment: .bottom) {
                LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
            }
            .overlay(alignment: .bottomLeading) {
                VStack {
                    Spacer()
                    Text(exhibition.name)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding()
            }
            .clipShape(shape)
            .overlay {
                shape
                    .inset(by: 0.5)
                    .stroke(.gray, lineWidth: 0.5)
            }
            .padding(.horizontal)
    }

    @ViewBuilder var backgroundImage: some View {
        AsyncImage(
            url: exhibition.previewImageUrl,
            content: { image in
                image
                    .resizable()
                    .scaleEffect(1.2)
                    .aspectRatio(contentMode: .fill)
            },
            placeholder: {
                Color.yellow
            }
        )
    }
}
