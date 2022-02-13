import Foundation

// NOTE: Models inside a section are in alphabetical order.

public struct Common {
    public struct ErrorMessage {
        public struct Response: Error, Decodable {
            public let message: String?
            public let errorCode: String?
            public var statusCode: Int?

            public var localizedDescription: String {
                return """

******************** ERROR INFO ********************
Message: \(message ?? "empty message")
Error Code: \(errorCode ?? "no internal error code")
StatusCode: \(statusCode ?? 0)
"""
            }
        }
    }
}
