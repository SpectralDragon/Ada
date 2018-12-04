import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ada_swiftpmTests.allTests),
    ]
}
#endif