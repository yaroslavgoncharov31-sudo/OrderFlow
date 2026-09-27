internal import Foundation
@testable import OrderFlow

struct MockNetworkManager: OrderPlacing {
    enum Behavior {
        case success(Order)
        case failure(Error)
    }

    var behavior: Behavior

    func placeOrder(order: OrderFlow.Order) async throws -> OrderFlow.Order {
        switch  behavior {
        case .success(let order):
            return order
        case .failure(let error):
            throw error
        }
    }
}
