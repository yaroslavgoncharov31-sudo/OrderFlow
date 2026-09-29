import Foundation

enum PlaceOrderError: Error {
    case invalidDeliveryDetails
}

struct PlaceOrderUseCase {
    let repository: OrderRepository

    func execute(order: Order, details: DeliveryDetails) async throws -> Order {
        guard details.hasValidAddress else {
            throw PlaceOrderError.invalidDeliveryDetails
        }
        return try await repository.placeOrder(order: order, deliveryDetails: details)
    }
}
