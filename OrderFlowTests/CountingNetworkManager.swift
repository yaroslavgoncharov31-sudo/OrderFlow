internal import Foundation
@testable import OrderFlow

@MainActor
final class CountingNetworkManager: OrderPlacing {
     var callCount = 0
    private var continuation: CheckedContinuation<Void, Never>?


    func placeOrder(order: Order) async throws -> Order {
        callCount += 1
        await withCheckedContinuation { continuation = $0 }
        return order
    }

    func resume() {
        continuation?.resume()
        continuation = nil
    }
}
