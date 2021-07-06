import XCTest
@testable import ChuckleWrapper

final class ChuckleWrapperTests: XCTestCase {
    func testJoke() {
        guard let joke = ChuckleWrapper.joke() else {
            XCTFail()
            return
        }
        print("""
            ---
            \(joke)
            ---
            """)
        XCTAssertFalse(joke.isEmpty)
    }
}
