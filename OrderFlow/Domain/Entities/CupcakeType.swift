import Foundation

enum CupcakeType: String, CaseIterable, Codable {
    case vanilla = "Vanilla"
    case chocolate = "Chocolate"
    case strawberry = "Strawberry"
    case rainbow = "Rainbow"

    var cost: Decimal {
        switch self {
        case .vanilla:
            2.0
        case .chocolate:
            2.0
        case .strawberry:
            2.5
        case .rainbow:
            4.0
        }
    }
}

