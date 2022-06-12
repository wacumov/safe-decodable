struct OptionalDecodable<T: Decodable>: Decodable {
    let value: T?

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            value = try container.decode(T.self)
        } catch {
            value = nil
        }
    }
}
