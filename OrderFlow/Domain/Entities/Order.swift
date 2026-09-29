import Foundation

struct Order: Equatable {
    var type: CupcakeType = .chocolate
    var quantity = 3
    var extraFrosting = false
    var addSprinkles = false

    var cost: Decimal {
        var cost = type.cost * Decimal(quantity)

        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
}
