internal import Testing
@testable import OrderFlow
internal import Foundation

@MainActor
struct OrderFlowTests {
    let order = Order()

    @MainActor
    @Suite struct CostCalculation {
        let order = Order()

        @Test func costCalculation_chocolateType_returnsBaseCost() async throws {
            order.type = .chocolate
            order.quantity = 3

            #expect(order.cost == 6)
        }
        @Test func costCalculation_strawberryType_returnBaseCost() async throws {
            order.type = .strawberry
            order.quantity = 3

            #expect(order.cost == 7.5)
        }
        @Test func costCalculation_vanillaType_returnBaseCost() async throws {
            order.type = .vanilla
            order.quantity = 3

            #expect(order.cost == 6)
        }

        @Test func costCalculation_rainbowType_returnBaseCost() async throws {
            order.type = .rainbow
            order.quantity = 3

            #expect(order.cost == 12)
        }

        @Test func costCalculation_extraFrosting() async throws {
            order.type = .chocolate
            order.quantity = 3
            order.extraFrosting = true

            #expect(order.cost == 9)
        }

        @Test func costCalculation_extraFrosting_addSprinkles() async throws {
            order.type = .chocolate
            order.quantity = 3
            order.extraFrosting = true
            order.addSprinkles = true

            #expect(order.cost == 10.5)
        }

        @Test func costCalculation_addSprinkles() async throws {
            order.type = .chocolate
            order.quantity = 3
            order.addSprinkles = true

            #expect(order.cost == 7.5)
        }
    }

    @MainActor
    @Suite struct AddressValidation {
        let order = Order()

        @Test func emptyName_returnsInvalid() async throws {
            order.name = ""
            order.streetAddress = "TestStreet"
            order.city = "TestCity"
            order.email = "test@mail.com"
            order.zip = "111111"

            #expect(order.hasValidAddress == false)
        }

        @Test func emptyStreetAddress_returnsInvalid() async throws {
            order.name = "TestName"
            order.streetAddress = ""
            order.city = "TestCity"
            order.email = "test@mail.com"
            order.zip = "111111"

            #expect(order.hasValidAddress == false)
        }

        @Test func emptyCity_returnsInvalid() async throws {
            order.name = "TestName"
            order.streetAddress = "TestStreet"
            order.city = ""
            order.email = "test@mail.com"
            order.zip = "111111"

            #expect(order.hasValidAddress == false)
        }

        @Test func emptyEmail_returnsInvalid() async throws {
            order.name = "TestName"
            order.streetAddress = "TestStreet"
            order.city = "TestCity"
            order.email = ""
            order.zip = "111111"

            #expect(order.hasValidAddress == false)
        }

        @Test func emptyZip_returnsInvalid() async throws {
            order.name = "TestName"
            order.streetAddress = "TestStreet"
            order.city = "TestCity"
            order.email = "test@mail.com"
            order.zip = ""

            #expect(order.hasValidAddress == false)
        }

        @Test func tooLongZip_returnsInvalid() async throws {
            order.name = "TestName"
            order.streetAddress = "TestStreet"
            order.city = "TestCity"
            order.email = "test@mail.com"
            order.zip = "11111111111111111"

            #expect(order.hasValidAddress == false)
        }

        @Test func emailWithNoAtSign_returnsInvalid() async throws {
            order.name = "TestName"
            order.streetAddress = "TestStreet"
            order.city = "TestCity"
            order.email = "testmail.com"
            order.zip = "111111"

            #expect(order.hasValidAddress == false)
        }

        @Test func whitespaces_returnsInvalid() async throws {
            order.name = "     "
            order.streetAddress = "TestStreet"
            order.city = "TestCity"
            order.email = "test@mail.com"
            order.zip = "111111"

            #expect(order.hasValidAddress == false)
        }

        @Test func zipAtMaxLength_returnsValid() async throws {
            order.name = "TestName"
            order.streetAddress = "TestStreet"
            order.city = "TestCity"
            order.email = "test@mail.com"
            order.zip = String(repeating: "1", count: 16)

            #expect(order.hasValidAddress == true)
        }

        @Test func allFieldsValid_returnsValid() async throws {
            order.name = "TestName"
            order.streetAddress = "TestStreet"
            order.city = "TestCity"
            order.email = "test@mail.com"
            order.zip = "111111"

            #expect(order.hasValidAddress == true)
        }
    }
    @Test func resetValid() async throws {
        order.type = .rainbow
        order.quantity = 20
        order.addSprinkles = true
        order.specialRequestEnabled = true
        order.reset()

        #expect(order.type == .chocolate)
        #expect(order.quantity == 3)
        #expect(order.specialRequestEnabled == false)

    }

    @Test func specialRequestEnabled_resets() async throws {
        order.addSprinkles = true
        order.extraFrosting = true

        order.specialRequestEnabled = false

        #expect(order.extraFrosting == false)
        #expect(order.addSprinkles == false)
    }
}


