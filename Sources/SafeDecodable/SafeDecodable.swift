@propertyWrapper
public struct SafeDecodable<T: Decodable>: Decodable {
    public let wrappedValue: T?

    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            wrappedValue = try (container.decode(OptionalDecodable<T>.self)).value
        } catch {
            wrappedValue = nil
        }
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: SafeDecodable<T>.Type, forKey key: Self.Key) throws -> SafeDecodable<T> where T: Decodable {
        try decodeIfPresent(type, forKey: key) ?? SafeDecodable<T>(wrappedValue: nil)
    }
}
