import Foundation

struct OrderDTO: Codable {
    let type: CupcakeType
    let quantity: Int
    let specialRequestEnabled: Bool
    let extraFrosting: Bool
    let addSprinkles: Bool
    let name: String
    let streetAddress: String
    let zip: String
    let city: String
    let email: String
}
