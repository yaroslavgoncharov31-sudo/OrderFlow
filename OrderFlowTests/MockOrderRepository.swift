internal import Foundation
@testable import OrderFlow

struct MockOrderRepository: OrderRepository {
    enum Behavior {
        case success(Order)
        case failure(Error)
    }

    var behavior: Behavior

    func placeOrder(order: Order, deliveryDetails: DeliveryDetails) async throws -> Order {
        switch behavior {
        case .success(let order):
            return order
        case .failure(let error):
            throw error
        }
    }
}
