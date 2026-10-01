
enum OrderMapper {
    static func toDTO(order: Order, deliveryDetails: DeliveryDetails) -> OrderDTO {
        OrderDTO(type: order.type,
                 quantity: order.quantity,
                 specialRequestEnabled: order.specialRequestEnabled,
                 extraFrosting: order.extraFrosting,
                 addSprinkles: order.addSprinkles,
                 name: deliveryDetails.name,
                 streetAddress: deliveryDetails.streetAddress,
                 zip: deliveryDetails.zip,
                 city: deliveryDetails.city,
                 email: deliveryDetails.email
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
