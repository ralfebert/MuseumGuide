import SwiftUI

struct AsyncResultView<T, Content: View>: View {
    var result: AsyncResult<T>
    var content: (_ item: T) -> Content

    init(result: AsyncResult<T>, @ViewBuilder content: @escaping (_ item: T) -> Content) {
        self.result = result
        self.content = content
    }

    var body: some View {
        if result.inProgress {
            ProgressView()
        } else {
            switch result.value {
            case .none:
                EmptyView()
            case let .success(value):
                content(value)
            case let .failure(error):
                ErrorView(error: error)
            }
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
