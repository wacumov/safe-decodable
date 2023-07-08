@propertyWrapper
public struct SafeDecodableArray<Item: Decodable>: Decodable {
    public let wrappedValue: [Item]

    public init(wrappedValue: [Item]) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            let items = try container.decode([OptionalDecodable<Item>].self)
            wrappedValue = items.compactMap(\.value)
        } catch {
            wrappedValue = []
        }
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(_ type: SafeDecodableArray<T>.Type, forKey key: Self.Key) throws -> SafeDecodableArray<T> where T: Decodable {
        try decodeIfPresent(type, forKey: key) ?? SafeDecodableArray<T>(wrappedValue: [])
    }
}
