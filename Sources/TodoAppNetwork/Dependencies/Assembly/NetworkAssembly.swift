import Foundation
import Swinject
import Logging

public struct NetworkAssembly: Assembly {

    var logLevel: Logger.Level
    var baseUrl: String
    var apiKey: String

    public init(logLevel: Logger.Level, baseUrl: String, apiKey: String) {
        self.logLevel = logLevel
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }

    public func assemble(container: Container) {

        container.register(Logger.self) { _ in
            var logger = Logger(label: "todoapp.network")
            logger.logLevel = logLevel
            return logger
        }

        container.register(TodoApiProtocol.self) { r in
            let logger = r.resolve(Logger.self)!
            return TodoApi(logger: logger, baseUrl: baseUrl, apiKey: apiKey)
        }.inObjectScope(.container)
    }
}
