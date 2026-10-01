internal import Testing
@testable import OrderFlow

@MainActor
struct MapperTests {

    @Test func mapperToDomain_mapsAllFields() async throws {
        let dto = OrderDTO(
            type: .chocolate,
            quantity: 3,
            specialRequestEnabled: true,
            extraFrosting: true,
            addSprinkles: true,
            name: "TestName",
            streetAddress: "TestAddress",
            zip: "111111",
            city: "TestCity",
            email: "example@mail.com"
        )
        let result = OrderMapper.toDomain(orderDTO: dto)

        #expect(result.order.type == .chocolate)
        #expect(result.order.quantity == 3)
        #expect(result.order.specialRequestEnabled == true)
        #expect(result.order.extraFrosting == true)
        #expect(result.order.addSprinkles == true)
        #expect(result.details.name == "TestName")
        #expect(result.details.streetAddress == "TestAddress")
        #expect(result.details.zip == "111111")
        #expect(result.details.city == "TestCity")
        #expect(result.details.email == "example@mail.com")
    }

    @Test func mapperToDto_mapsAllFields() async throws {
        let order = Order(
            type: .chocolate,
            quantity: 3,
            extraFrosting: true,
            addSprinkles: true,
            specialRequestEnabled: true
        )
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "TestAddress",
            zip: "111111",
            city: "TestCity",
            email: "example@mail.com"
        )
        let dto = OrderMapper.toDTO(order: order, deliveryDetails: details)

        #expect(dto.type == .chocolate)
        #expect(dto.quantity == 3)
        #expect(dto.specialRequestEnabled == true)
        #expect(dto.extraFrosting == true)
        #expect(dto.addSprinkles == true)
        #expect(dto.name == "TestName")
        #expect(dto.streetAddress == "TestAddress")
        #expect(dto.zip == "111111")
        #expect(dto.city == "TestCity")
        #expect(dto.email == "example@mail.com")
    }

    @Test func roundTrip_preservesData() async throws {
        let order = Order(
            type: .chocolate,
            quantity: 3,
            extraFrosting: true,
            addSprinkles: true,
            specialRequestEnabled: true
        )
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "TestAddress",
            zip: "111111",
            city: "TestCity",
            email: "example@mail.com"
        )
        
        let dto = OrderMapper.toDTO(order: order, deliveryDetails: details)
        let result = OrderMapper.toDomain(orderDTO: dto)
        #expect(result.order == order)
        #expect(result.details == details)
    }
}
