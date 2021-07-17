import SwiftUI

struct AsyncResultView<T, Content: View>: View {
    var result: AsyncResult<T>
    var content: (_ item: T) -> Content

    init(result: AsyncResult<T>, @ViewBuilder content: @escaping (_ item: T) -> Content) {
        self.result = result
        self.content = content
    }

    var body: some View {
        switch result {
        case .empty:
            EmptyView()
        case .inProgress:
            ProgressView()
        case let .success(data):
            content(data)
        case let .failure(error):
            ErrorView(error: error)
        }
    }
}

struct ErrorView: View {
    let error: Error

    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud")
            Text(error.localizedDescription)
        }
    }
}
