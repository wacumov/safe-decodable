enum Enum: String, Decodable {
    case one = "ONE"
}

struct Struct: Decodable {
    let one: String
}
