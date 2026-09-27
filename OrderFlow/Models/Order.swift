import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
        case _email = "email"
    }
    var type: CupcakeType = .chocolate
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var zip = ""
    var city = ""
    var email = ""
    var hasValidAddress: Bool {
         [name, streetAddress, zip, city, email]
            .allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty } && email.contains("@") && zip.count <= 16
    }
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

    init() {
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        zip = UserDefaults.standard.string(forKey: "zip") ?? ""
        email = UserDefaults.standard.string(forKey: "email") ?? ""
    }

     func saveAddress() {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(zip, forKey: "zip")
        UserDefaults.standard.set(email, forKey: "email")
    }
    
    func reset() {
        type = .chocolate
        quantity = 3
        specialRequestEnabled = false
    }
}
