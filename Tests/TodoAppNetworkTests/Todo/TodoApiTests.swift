import XCTest
@testable import TodoAppNetwork
import Combine
import Logging

final class TodoApiTests: XCTestCase {

    @TestInjected private var todoApi: TodoApiProtocol
    @TestInjected private var logger: Logger

    func testGetTodoList_shouldReturnSuccess() async {

        var success = false
        do {
            let result = try await todoApi.getTodoList()
            logger.info("Received value: \(result)")
            logger.info("Operation completed successfully.")
            success = true
        } catch let error {
            logger.error("Operation failed with error: \(error.localizedDescription)")
        }
        XCTAssertTrue(success)
    }
}
