import SafeDecodable
import XCTest

final class SafeDecodableArrayTests: XCTestCase {
    private let decoder = JSONDecoder()

    private struct AA: Decodable {
        @SafeDecodableArray var e: [Enum]
    }

    private struct BB: Decodable {
        @SafeDecodableArray var s: [Struct]
    }

    func testDecodeMissingArrayOfEnum() throws {
        let json =
            """
            {}
            """
        let aa = try decoder.decode(AA.self, from: Data(json.utf8))
        XCTAssert(aa.e.isEmpty)
    }

    func testDecodeValidArrayOfEnum() throws {
        let json =
            """
            {"e": ["ONE"]}
            """
        let aa = try decoder.decode(AA.self, from: Data(json.utf8))
        XCTAssertEqual(aa.e.count, 1)
    }

    func testDecodeArrayOfEnumWithInvalidItem() throws {
        let json =
            """
            {"e": ["ONE", "UNKNOWN"]}
            """
        let aa = try decoder.decode(AA.self, from: Data(json.utf8))
        XCTAssertEqual(aa.e.count, 1)
    }

    func testDecodeMissingArrayOfStruct() throws {
        let json =
            """
            {}
            """
        let bb = try decoder.decode(BB.self, from: Data(json.utf8))
        XCTAssert(bb.s.isEmpty)
    }

    func testDecodeValidArrayOfStruct() throws {
        let json =
            """
            {"s": [{"one": "value"}]}
            """
        let bb = try decoder.decode(BB.self, from: Data(json.utf8))
        XCTAssertEqual(bb.s.count, 1)
    }

    func testDecodeArrayOfStructWithInvalidItem() throws {
        let json =
            """
            {"s": [{"one": "value"}, {"one": 1}]}
            """
        let bb = try decoder.decode(BB.self, from: Data(json.utf8))
        XCTAssertEqual(bb.s.count, 1)
    }
}
