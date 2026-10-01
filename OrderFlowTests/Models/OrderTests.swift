internal import Testing
@testable import OrderFlow
internal import Foundation

@MainActor
struct OrderFlowTests {
    let order = Order()

    @MainActor
    @Suite struct CostCalculation {

        @Test func costCalculation_chocolateType_returnsBaseCost() async throws {
            let order = Order(type: .chocolate, quantity: 3)
            #expect(order.cost == 6)
        }

        @Test func costCalculation_strawberryType_returnBaseCost() async throws {
            let order = Order(type: .strawberry, quantity: 3)

            #expect(order.cost == 7.5)
        }

        @Test func costCalculation_vanillaType_returnBaseCost() async throws {
            let order = Order(type: .vanilla, quantity: 3)

            #expect(order.cost == 6)
        }

        @Test func costCalculation_rainbowType_returnBaseCost() async throws {
            let order = Order(type: .rainbow, quantity: 3)

            #expect(order.cost == 12)
        }

        @Test func costCalculation_extraFrosting() async throws {
            let order = Order(type: .chocolate, quantity: 3, extraFrosting: true)

            #expect(order.cost == 9)
        }

        @Test func costCalculation_extraFrosting_addSprinkles() async throws {
            let order = Order(type: .chocolate, quantity: 3, extraFrosting: true, addSprinkles: true)

            #expect(order.cost == 10.5)
        }

        @Test func costCalculation_addSprinkles() async throws {
            let order = Order(type: .chocolate, quantity: 3, addSprinkles: true)

            #expect(order.cost == 7.5)
        }
        @Test func specialRequestEnabled_resets() async throws {
            var order = Order(extraFrosting: true, addSprinkles: true)

            order.specialRequestEnabled = false

            #expect(order.extraFrosting == false)
            #expect(order.addSprinkles == false)
        }
    }
}



