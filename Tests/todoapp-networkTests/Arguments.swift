@testable import todoapp_network
import Foundation

struct Arguments {

    static var baseUrl: String {
        let optionKey = "-base-url"
        return value(for: optionKey)
    }

    static var apiKey: String {
        let optionKey = "-api-key"
        return value(for: optionKey)
    }

    static func value(for optionKey: String) -> String {
        let arguments = CommandLine.arguments
        guard arguments.contains(optionKey) else { return "" }
        guard let index = arguments.firstIndex(of: optionKey) else { return "" }
        guard arguments.count > index + 1 else { return "" }
        return arguments[index + 1]
    }
}
