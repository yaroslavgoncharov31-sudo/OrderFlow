import Foundation

enum Mapper {
    static func toDTO(order: Order, deliveruDetails: DeliveryDetails) -> OrderDTO {
        OrderDTO(type: order.type,
                 quantity: order.quantity,
                 specialRequestEnabled: order.specialRequestEnabled,
                 extraFrosting: order.extraFrosting,
                 addSprinkles: order.addSprinkles,
                 name: deliveruDetails.name,
                 streetAddress: deliveruDetails.streetAddress,
                 zip: deliveruDetails.zip,
                 city: deliveruDetails.city,
                 email: deliveruDetails.email
        )
    }
    static func toDomain(orderDTO: OrderDTO) -> (order: Order, details: DeliveryDetails) {
        let order = Order(
            type: orderDTO.type,
            quantity: orderDTO.quantity,
            extraFrosting: orderDTO.extraFrosting,
            addSprinkles: orderDTO.addSprinkles,
            specialRequestEnabled: orderDTO.specialRequestEnabled
        )
        let details = DeliveryDetails(
            name: orderDTO.name,
            streetAddress: orderDTO.streetAddress,
            zip: orderDTO.zip,
            city: orderDTO.city,
            email: orderDTO.email
        )
        return (order, details)
    }
}
