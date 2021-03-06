@testable import TodoAppNetwork
import Foundation
import Swinject

class TestDependencyProvider {

    static let shared = TestDependencyProvider()

    private let container = Container()
    let assembler: Assembler

    private init() {
        assembler = Assembler(
            [
                TestUtilAssembly(),
                TodoAppNetwork.NetworkAssembly(
                    logLevel: .trace,
                    baseUrl: Arguments.baseUrl,
                    apiKey: Arguments.apiKey
                )
            ],
            container: container
        )
    }
}

@propertyWrapper
internal struct TestInjected<T> {
    private let resolver = (TestDependencyProvider.shared.assembler.resolver as! Container).synchronize() // swiftlint:disable:this force_cast line_length

    init() {}

    lazy var wrappedValue: T = {
        return resolver.resolve(T.self)!
    }()
}
