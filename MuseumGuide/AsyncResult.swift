import Foundation

/**
 AsyncResult represents the state of an asynchronous task and its result.

 It is similar to Swift's Result type but can also represent a 'no value' and 'work in progress' state.

 This type was created for allowing a generic SwiftUI View that handles the 'no value' / 'work in progress' / 'error' states which are often very similar for many different Views. See ``AsyncResultView`` for a simple example implementation for such a view.

 It might be tempting to make this an enum with empty/inProgress/success/failure cases. But in some use cases this turns out rather unfortunate: If you already have a success result and then start a task to refresh, you might want to keep the current value until the task is completed. This cannot be represented with an enum.
 */
@frozen public struct AsyncResult<Success> {
    public init(value: Success? = nil, error: Error? = nil, inProgress: Bool = false) {
        self.value = value
        self.error = error
        self.inProgress = inProgress
    }

    public var value: Success?
    public var error: Error?
    public var inProgress: Bool
}
