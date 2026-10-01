import Foundation

enum PlaceOrderError: Error {
    case invalidDeliveryDetails
}

struct PlaceOrderUseCase {
    let repository: OrderRepository

    func execute(order: Order, deliveryDetails: DeliveryDetails) async throws -> Order {
        guard deliveryDetails.hasValidAddress else {
            throw PlaceOrderError.invalidDeliveryDetails
        }
        return try await repository.placeOrder(order: order, deliveryDetails: deliveryDetails)
    }
}
