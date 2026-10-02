internal import Testing
@testable import OrderFlow

@MainActor
@Suite struct AddressValidation {
    @Test func emptyName_returnsInvalid() async throws {
        let details = DeliveryDetails(
            name: "",
            streetAddress: "TestAddress",
            zip: "111111",
            city: "TestCity",
            email: "example@mail.com"
        )

        #expect(details.hasValidAddress == false)
    }

    @Test func emptyStreetAddress_returnsInvalid() async throws {
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "",
            zip: "111111",
            city: "TestCity",
            email: "example@mail.com"
        )

        #expect(details.hasValidAddress == false)
    }

    @Test func emptyCity_returnsInvalid() async throws {
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "TestAddress",
            zip: "111111",
            city: "",
            email: "example@mail.com"
        )

        #expect(details.hasValidAddress == false)
    }

    @Test func emptyEmail_returnsInvalid() async throws {
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "TestAddress",
            zip: "111111",
            city: "TestCity",
            email: ""
        )

        #expect(details.hasValidAddress == false)
    }

    @Test func emptyZip_returnsInvalid() async throws {
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "TestAddress",
            zip: "",
            city: "TestCity",
            email: "example@mail.com"
        )

        #expect(details.hasValidAddress == false)
    }

    @Test func tooLongZip_returnsInvalid() async throws {
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "TestAddress",
            zip: "11111111111111111",
            city: "TestCity",
            email: "example@mail.com"
        )

        #expect(details.hasValidAddress == false)
    }

    @Test func emailWithNoAtSign_returnsInvalid() async throws {
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "TestAddress",
            zip: "111111",
            city: "TestCity",
            email: "examplemail.com"
        )

        #expect(details.hasValidAddress == false)
    }

    @Test func whitespaces_returnsInvalid() async throws {
        let details = DeliveryDetails(
            name: "      ",
            streetAddress: "TestAddress",
            zip: "111111",
            city: "TestCity",
            email: "example@mail.com"
        )


        #expect(details.hasValidAddress == false)
    }

    @Test func zipAtMaxLength_returnsValid() async throws {
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "TestStreet",
            zip: String(repeating: "1", count: 16),
            city: "TestCity",
            email: "test@mail.com"
        )
        #expect(details.hasValidAddress == true)
    }

    @Test func allFieldsValid_returnsValid() async throws {
        let details = DeliveryDetails(
            name: "TestName",
            streetAddress: "TestAddress",
            zip: "111111",
            city: "TestCity",
            email: "example@mail.com"
        )

        #expect(details.hasValidAddress == true)
    }
}



