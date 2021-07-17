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
        } else if let error = result.error {
            ErrorView(error: error)
        } else if let value = result.value {
            content(value)
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
