import Foundation

protocol OrderRepository {
    func placeOrder(order: Order, deliveryDetails: DeliveryDetails) async throws -> Order  
}
