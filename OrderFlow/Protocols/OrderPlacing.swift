import Foundation

protocol OrderPlacing {
    func placeOrder(order: Order) async throws -> Order
}
