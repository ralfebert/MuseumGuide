import Foundation

@frozen public enum AsyncResult<Success> {
    case empty

    case inProgress

    /// A success, storing a `Success` value.
    case success(Success)

    /// A failure, storing a `Failure` value.
    case failure(Error)
}
