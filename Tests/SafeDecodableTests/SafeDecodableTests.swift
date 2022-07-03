import SafeDecodable
import XCTest

final class SafeDecodableTests: XCTestCase {
    private let decoder = JSONDecoder()

    private struct A: Decodable {
        @SafeDecodable var e: Enum?
    }

    private struct B: Decodable {
        @SafeDecodable var s: Struct?
    }

    func testDecodeMissingEnum() throws {
        let json =
            """
            {}
            """
        let a = try decoder.decode(A.self, from: Data(json.utf8))
        XCTAssertNil(a.e)
    }

    func testDecodeValidEnum() throws {
        let json =
            """
            {"e": "ONE"}
            """
        let a = try decoder.decode(A.self, from: Data(json.utf8))
        XCTAssertNotNil(a.e)
    }

    func testDecodeInvalidEnum() throws {
        let json =
            """
            {"e": "UNKNOWN"}
            """
        let a = try decoder.decode(A.self, from: Data(json.utf8))
        XCTAssertNil(a.e)
    }

    func testDecodeMissingStruct() throws {
        let json =
            """
            {}
            """
        let b = try decoder.decode(B.self, from: Data(json.utf8))
        XCTAssertNil(b.s)
    }

    func testDecodeValidStruct() throws {
        let json =
            """
            {"s": {"one": "value"}}
            """
        let b = try decoder.decode(B.self, from: Data(json.utf8))
        XCTAssertEqual(b.s?.one, "value")
    }

    func testDecodeInvalidStruct() throws {
        let json =
            """
            {"s": {"one": 1}}
            """
        let b = try decoder.decode(B.self, from: Data(json.utf8))
        XCTAssertNil(b.s)
    }
}
